$(document).ready(function() {

  $(".delete").click(function(e) {
    e.preventDefault();
    var $this = $(this),
        form = $('<form></form>');
    form
      .attr({
        method: 'post',
        action: $this.attr('href')
      })
      .hide()
      .append('<input type="hidden" />')
      .find('input')
      .attr({
        'name': '_method',
        'value': 'delete'
      })
    $this.append(form);
    form.submit();
  });
});
