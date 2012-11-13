var deleteUser = function() {
  var id = $('.edit-user-container .edit-user-delete-account').attr('id')

  $.ajax({
    url: '/users/' + id,
    type: 'DELETE',
    dataType: 'json',
    data: { id: id },
    success: function(result) {
      if (result.success) {
        logout();
      }
    }
  });
};

$(function() {
  // Setup action to show a confirmation box
  $('.edit-user-container .edit-user-delete-account').on(
    'click',
    function() {
      $('#editUserDeleteDialog').dialog({
        resizable: false,
        height:180,
        modal: true,
        buttons: {
          "Yes": function() {            
            $(this).dialog("close");
            deleteUser();
          },
          "No": function() {
            $(this).dialog("close");
          }
        }
      });
    }
  );
});
