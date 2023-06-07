package main

import (
	"go/ast"

	"github.com/nicolasdilley/gomela/promela"
)

type GINGER_SCOPE int

const (
	OUT_OF_SCOPE = iota
	IN_HARD_SCOPE
	IN_SOFT_SCOPE
)

type gingerScopeCheckVisitor struct {
	inFor       bool
	visitedFuns map[*ast.FuncDecl]struct{}
	inScopeHard *bool
	inScopeSoft *bool
	outOfScope  *bool
	model       *promela.Model
}

// newGingerScopeCheckVisitor creates a new visitor for
// coarsely checking whether a fragment is in the scope of Ginger.
func newGingerScopeCheckVisitor(m *promela.Model) gingerScopeCheckVisitor {
	return gingerScopeCheckVisitor{
		inScopeHard: new(bool),
		inScopeSoft: new(bool),
		outOfScope:  new(bool),
		model:       m,
	}
}

// Visit allows gingerScopeCheckVisitor to implement the visitor pattern.
func (v gingerScopeCheckVisitor) Visit(n ast.Node) ast.Visitor {
	if *v.outOfScope {
		return nil
	}

	switch n := n.(type) {
	case *ast.FuncDecl:
		if _, ok := v.visitedFuns[n]; ok {
			return nil
		}
		v.visitedFuns[n] = struct{}{}
	case *ast.SendStmt:
		if _, ok := n.Chan.(*ast.Ident); ok {
			*v.inScopeHard = *v.inScopeHard || v.inFor
		} else {
			*v.inScopeSoft = *v.inScopeSoft || v.inFor
		}
	case *ast.SelectStmt:
		*v.outOfScope = true
	case *ast.UnaryExpr:

	case *ast.ForStmt:
		if n.Cond == nil && n.Init == nil && n.Post == nil {
			*v.outOfScope = true
			return nil
		}
		v.inFor = true
	case *ast.CallExpr:
		if fun, _, _, err := v.model.FindFunDecl(n); err != nil {
			v2 := v
			v2.inFor = false
			ast.Walk(v2, fun)
		}
	}

	return v
}

// checkInGingerScope checks whether a Promela model falls in
// the Ginger scope.
func checkInGingerScope(m *promela.Model, n *ast.FuncDecl) GINGER_SCOPE {
	v := newGingerScopeCheckVisitor(m)

	ast.Walk(v, n)

	switch {
	case *v.outOfScope:
		return OUT_OF_SCOPE
	case *v.inScopeSoft:
		return IN_SOFT_SCOPE
	case *v.inScopeHard:
		return IN_HARD_SCOPE
	}

	return OUT_OF_SCOPE
}
