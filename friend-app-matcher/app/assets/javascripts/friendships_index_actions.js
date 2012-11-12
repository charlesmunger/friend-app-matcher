/**
 * Setup what happens when action is selected
 */

// Ignore friends and remove item from table
var ignoreFriendAndHide = function() {
  var checked = table.getSelected();

  // Update the friendship with ajax call and remove DOM item
  $.each(checked, function(index, elem) {
    var friendshipId = $(elem).find('.friend-item').attr('id');

    $.ajax({
      url: '/friendships',
      type: 'PUT',
      dataType: 'json',
      data: {
        id: friendshipId,
        ignore: true
      },
      success: function(result) {
        if (result.success) {
          $(elem).remove();
        }
      }
    });
  });
};

// Setup event handlers
$(function() {
  $('.service-list .ignore-only .actions-ignore').on(
    'click', ignoreFriendAndHide
  );
});
