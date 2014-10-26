eadir=eaModule
penmdir=penMonModule
eaBase: ; ocamlopt -I $(eadir)/ -o eabase $(eadir)/eaBase.ml
eaPoor: ; ocamlopt -I $(eadir)/ -o eapoor $(eadir)/eaBase.ml $(eadir)/eaPoor.ml
ea: ; ocamlopt -I $(eadir)/ -o ea $(eadir)/eaBase.ml $(eadir)/ea.ml
penmon: ; ocamlopt -I $(eadir)/ -I $(penmdir)/ -o penmon $(penmdir)/pen_m.ml



.PHONY: clean all

clean: ; rm $(eadir)/*.o $(eadir)/*.cm* $(penmdir)/*.o $(penmdir)/*.cm* eabase eapoor ea penmon
all: eaBase eaPoor ea penmon
