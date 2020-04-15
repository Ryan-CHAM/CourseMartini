
$("#new_comment").change(function() { 
  $form = $(this);
  $input_value = $form.children("#comment_workload_score").val();
  $label = $form.children("#comment_workload_score").siblings("label");
  $label.text("workload score (0 ~ 5)" + $input_value);
})
