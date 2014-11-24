open Should

let int_test_case () =
    let x = 123 in begin
        x $hould # equal 123;
        x $hould # not # equal 0;

        x $hould # be # above 122;
        x $hould # be # at # most 124;

        x $hould # be # within (122,123);
        x $houldn't # be # within (1,3)
    end


let list_test_case () =
    let x = [1; 2; 3] in begin
        list x $houldn't # be # empty;
        list x $hould # have # length 3;
        list x $hould # contain 2;
        list x $hould # not # contain 0
    end

let fun_test_case () =
    let f = (function "" -> invalid_arg "f" | s -> String.lowercase s) in begin
        calling f "" $hould # raise # any # exn;
        calling f "" $hould # raise # exn # prefixed "Invalid_argument";
        calling f "foo" $houldn't # raise # any # exn
    end

let lala () = Printf.printf "%s\n" "lala"

let lala_test ()=
  1 $hould # equal 1

let _= lala()

