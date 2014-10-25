eaBase: ; ocamlopt -o eabase eaBase.ml
eaPoor: ; ocamlopt -o eapoor eaBase.ml eaPoor.ml


all: clean eaBase eaPoor
.PHONY: clean

clean: ; rm *.o *.cm* eabase eapoor
