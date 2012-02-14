$(function() {
  $("#bank a.btn-success").popover({
    title: 'Meaning...',
    content: 'We will set <code>paid = true</code> for this transaction'
  });
  $("#bank a.btn-danger").popover({
    placement: 'left',
    title: 'Meaning...',
    content: 'We will set <code>paid = false</code> for this transaction'
  });
})
