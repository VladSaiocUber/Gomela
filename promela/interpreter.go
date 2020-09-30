package promela

import (
	"io/ioutil"
	"os"
	"path/filepath"

	"github.com/nicolasdilley/gomela/promela/promela_ast"
	"github.com/nicolasdilley/gomela/promela/promela_types"
)

type ForCounter struct { // used to create the labels to jump to for for select statement
	X       int
	Y       int
	In_for  bool // a flag to say if we are or not in a for loop if true update Y if false update X
	With_go bool // true if a go stmt was found inside
}

func Print(m *Model) {

	stmt := ""

	// print the bounds
	for _, c := range m.Defines {
		stmt += c.Print(0) + "\n"
	}

	// print the function inline
	for _, c := range m.Inlines {
		stmt += c.Print(0) + "\n"
	}

	stmt += "\n"

	stmt += "// " + m.Fileset.Position(m.Fun.Pos()).Filename + "\n"

	// add chans to the chandef
	chan_struct := promela_ast.ChanStructDef{Name: promela_ast.Ident{Name: "Chandef"}, Defs: []promela_ast.Chandef{}} // creating the struct that will represent the go channel
	sync := promela_ast.Chandef{Name: promela_ast.Ident{Name: "sync"}, Types: []promela_types.Types{promela_types.Int}, Size: promela_ast.Ident{Name: "0"}}
	async_send := promela_ast.Chandef{Name: promela_ast.Ident{Name: "async_send"}, Types: []promela_types.Types{promela_types.Int}, Size: promela_ast.Ident{Name: "0"}}
	async_rcv := promela_ast.Chandef{Name: promela_ast.Ident{Name: "async_rcv"}, Types: []promela_types.Types{promela_types.Int}, Size: promela_ast.Ident{Name: "0"}}
	sending := promela_ast.Chandef{Name: promela_ast.Ident{Name: "sending"}, Types: []promela_types.Types{promela_types.Int}, Size: promela_ast.Ident{Name: "0"}}
	closed := promela_ast.Chandef{Name: promela_ast.Ident{Name: "closing"}, Types: []promela_types.Types{promela_types.Bool}, Size: promela_ast.Ident{Name: "0"}}
	is_closed := promela_ast.Chandef{Name: promela_ast.Ident{Name: "is_closed"}, Types: []promela_types.Types{promela_types.Bool}, Size: promela_ast.Ident{Name: "0"}}
	chan_struct.Defs = append(chan_struct.Defs, sync, async_send, async_rcv, sending, closed, is_closed)

	// add attributes to the chandef
	size := promela_ast.DeclStmt{Name: promela_ast.Ident{Name: "size"}, Rhs: &promela_ast.Ident{Name: "0"}, Types: promela_types.Int}
	num_msgs := promela_ast.DeclStmt{Name: promela_ast.Ident{Name: "num_msgs"}, Rhs: &promela_ast.Ident{Name: "0"}, Types: promela_types.Int}
	chan_struct.Decls = append(chan_struct.Decls, size, num_msgs)

	// print Wgdef
	wg_struct := promela_ast.WgStructDef{Name: promela_ast.Ident{Name: "Wgdef"}, Defs: []promela_ast.Chandef{}} // creating the struct that will represent the go channel
	add := promela_ast.Chandef{Name: promela_ast.Ident{Name: "Add"}, Types: []promela_types.Types{promela_types.Int}, Size: promela_ast.Ident{Name: "0"}}
	wait := promela_ast.Chandef{Name: promela_ast.Ident{Name: "Wait"}, Types: []promela_types.Types{promela_types.Int}, Size: promela_ast.Ident{Name: "0"}}
	wg_struct.Defs = append(wg_struct.Defs, add, wait)

	b := promela_ast.BlockStmt{List: []promela_ast.Stmt{}}

	// setting the size of the int chan
	for _, c := range m.Global_vars {
		b.List = append(b.List, c)
	}

	if len(m.Chans) > 0 {
		stmt += chan_struct.Print(0)
	}
	if len(m.WaitGroups) > 0 {
		m.Proctypes = append(m.Proctypes, GenerateStructMonitor())
		stmt += wg_struct.Print(0)
	}
	stmt += "\n"
	stmt += b.Print(0)
	stmt += "\n\n"
	stmt += m.Init.Print(0)
	stmt += "\n"

	for _, proc := range m.Proctypes {
		stmt += proc.Print(0)
	}

	if len(m.Chans) > 0 {
		stmt += generateSyncChanMonitor() + GenerateEmptyChanMonitor() + GenerateFullChanMonitor() + GenerateNeitherChanMonitor() + GenerateClosedChanMonitor()
	}

	folder := "./" + m.Result_fodler + "/" + filepath.Base(m.Project_name)
	if _, err := os.Stat(folder); os.IsNotExist(err) {
		os.Mkdir(folder, os.ModePerm)
	}

	d1 := []byte(stmt)

	filename := folder + "/" + m.Name + ".pml"
	err := ioutil.WriteFile(filename, d1, 0644)

	if err != nil {
		panic(err)
	}

}
