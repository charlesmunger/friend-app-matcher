/**
 * Setup what happens when action is selected
 */

// Ignore friends
var ignoreFriend = function() {
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
          $(elem).find('.friend-item').addClass('ignored-friend');
        }
      }
    });
  });

};

// Unignore friends
var unignoreFriend = function() {
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
        ignore: false
      },
      success: function(result) {
        if (result.success) {
          $(elem).find('.friend-item').removeClass('ignored-friend');
        }
      }
    });
  });
};

// Setup event handlers
$(function() {
  $('.service-list .ignore-unignore-only .actions-ignore').on(
    'click', ignoreFriend
  );

  $('.service-list .ignore-unignore-only .actions-unignore').on(
    'click', unignoreFriend
  );
});
