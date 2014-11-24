eadir=eaModule
penmdir=penMonModule
testdir=tests
eaBase: ; ocamlfind ocamlc -I $(eadir)/ -o eabase $(eadir)/eaBase.ml
eaPoor: ; ocamlfind ocamlc -I $(eadir)/ -o eapoor $(eadir)/eaBase.ml $(eadir)/eaPoor.ml
ea: ; ocamlfind ocamlc -I $(eadir)/ -o ea $(eadir)/eaBase.ml $(eadir)/ea.ml
penmon: ; ocamlfind ocamlc -package batteries -linkpkg -I $(eadir)/ -I $(penmdir)/ $(penmdir)/pen_m.ml -o penmon 
test: ;ocamlfind ocamlc -package pa_ounit -package batteries -linkpkg -g -I $(eadir)/ -I $(penmdir)/ $(eadir)/eaBase.ml $(eadir)/eaPoor.ml $(eadir)/ea.ml $(penmdir)/*.ml $(testdir)/*.ml -o unit_tests

.PHONY: clean all

clean: ; rm $(eadir)/*.cm* $(penmdir)/*.cm* $(testdir)/*.cm* eabase eapoor ea penmon unit_tests *log *cache
all: eaBase eaPoor ea penmon test
