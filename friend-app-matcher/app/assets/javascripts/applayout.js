var logout = function() {
  $.ajax({
    url: '/users/sign_out',
    type: 'DELETE',
    complete: function(result, status) {
      // Javascript redirect
      document.location.href = '/users/sign_in';
    }
  });
};

$(function() {
  // Toggle display off user options when clicking on name
  $('.app-header-content .name-display').on('click', function() {
    $('.app-header-content .user-options-sub').toggle();
  });
});
