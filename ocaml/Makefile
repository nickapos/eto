eadir=eaModule
eaBase: ; ocamlopt -I $(eadir)/ -o eabase $(eadir)/eaBase.ml
eaPoor: ; ocamlopt -I $(eadir)/ -o eapoor $(eadir)/eaBase.ml $(eadir)/eaPoor.ml
ea: ; ocamlopt -I $(eadir)/ -o ea $(eadir)/eaBase.ml $(eadir)/ea.ml



.PHONY: clean all

clean: ; rm $(eadir)/*.o $(eadir)/*.cm* eabase eapoor ea
all: eaBase eaPoor ea
