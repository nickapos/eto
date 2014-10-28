eadir=eaModule
penmdir=penMonModule
eaBase: ; ocamlc -I $(eadir)/ -o eabase $(eadir)/eaBase.ml
eaPoor: ; ocamlc -I $(eadir)/ -o eapoor $(eadir)/eaBase.ml $(eadir)/eaPoor.ml
ea: ; ocamlc -I $(eadir)/ -o ea $(eadir)/eaBase.ml $(eadir)/ea.ml
penmon: ; ocamlfind ocamlc -package batteries -linkpkg -I $(eadir)/ -I $(penmdir)/ $(penmdir)/pen_m.ml -o penmon


.PHONY: clean all

clean: ; rm $(eadir)/*.o $(eadir)/*.cm* $(penmdir)/*.o $(penmdir)/*.cm* eabase eapoor ea penmon
all: eaBase eaPoor ea penmon
