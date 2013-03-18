
open OUnit
open Enum.Infix

let pint i = string_of_int i
let plist l = Utils.sprintf "%a"
  (Sequence.pp_seq Format.pp_print_int) (Sequence.of_list l)
let pstrlist l = Utils.sprintf "%a"
  (Sequence.pp_seq Format.pp_print_string) (Sequence.of_list l)

let test_singleton () =
  let e = Enum.singleton 42 in
  let gen = Enum.start e in
  OUnit.assert_equal 42 (Enum.next gen);
  OUnit.assert_raises Enum.EOG (fun () -> Enum.next gen);
  OUnit.assert_equal 1 (Enum.length e);
  ()

let test_iter () =
  let e = 1 -- 10 in
  OUnit.assert_equal ~printer:pint 10 (Enum.length e);
  OUnit.assert_equal [1;2] (Enum.to_list (1 -- 2));
  OUnit.assert_equal [1;2;3;4;5] (Enum.to_list (Enum.take 5 e));
  ()

let test_map () =
  let e = 1 -- 10 in
  let e' = Enum.map string_of_int e in
  OUnit.assert_equal ~printer:pstrlist ["9"; "10"] (Enum.to_list (Enum.drop 8 e'));
  ()

let suite =
  "test_enum" >:::
    [ "test_singleton" >:: test_singleton;
      "test_iter" >:: test_iter;
      "test_map" >:: test_map;
    ]
