eadir=eaModule
penmdir=penMonModule
eaBase: ; ocamlfind ocamlc -I $(eadir)/ -o eabase $(eadir)/eaBase.ml
eaPoor: ; ocamlfind ocamlc -I $(eadir)/ -o eapoor $(eadir)/eaBase.ml $(eadir)/eaPoor.ml
ea: ; ocamlfind ocamlc -I $(eadir)/ -o ea $(eadir)/eaBase.ml $(eadir)/ea.ml
penmon: ; ocamlfind ocamlc -package batteries -linkpkg  -I $(eadir)/ -I $(penmdir)/ $(penmdir)/pen_m.ml -o penmon 


.PHONY: clean all

clean: ; rm $(eadir)/*.cm* $(penmdir)/*.cm* eabase eapoor ea penmon
all: eaBase eaPoor ea penmon
