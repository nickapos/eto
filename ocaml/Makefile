eaBase: ; ocamlopt -o eabase eaBase.ml
eaPoor: ; ocamlopt -o eapoor eaBase.ml eaPoor.ml
ea: ; ocamlopt -o ea eaBase.ml ea.ml



.PHONY: clean all

clean: ; rm *.o *.cm* eabase eapoor ea
all: eaBase eaPoor ea
