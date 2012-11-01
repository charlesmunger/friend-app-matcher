function Table() {
  this.CHECKBOX_PROPERTY = 'aria-checked';

  this.selectAll = '.service-list .select-all-checkbox-container .checkbox';
  this.actions = '.service-list .actions';
  this.tableContentContainer = '.service-list-container';

  this.setupActions();
  this.setupCheckbox();
}

// Select events to display or hide the "actions" menu
Table.prototype.setupActions = function() {
  $(this.actions).hover(this.showActions, this.hideActions);
}

// Displays the "actions" menu
Table.prototype.showActions = function(evt) {
  $(this.actions + ' .actions-sublist').slideDown('fast');
}

// Hides the "actions" menu
Table.prototype.hideActions = function(evt) {
  $(this.actions + ' .actions-sublist').slideUp('fast');
}

// Setup event handlers on checkboxes
Table.prototype.setupCheckbox = function() {
  var table = this;

  $(table.selectAll).on('click', function(evt) {
    var selectAllElement = $(table.selectAll);
    if (!table.isSelected(selectAllElement)) {
      table.selectAllItems();
    }
    else {
      table.deselectAllItems();
    }
  });

  $(table.tableContentContainer + ' .checkbox').each(function(index, ele) {
    $(ele).on('click', function(evt) {
      var checkboxElement = $(ele);

      if (!table.isSelected(checkboxElement)) {
        checkboxElement.attr(table.CHECKBOX_PROPERTY, 'true');
        checkboxElement.find('.unchecked-item')
                       .attr('class', 'checked-item');
      }
      else {
        table.deselectSelectAll();
        checkboxElement.attr(table.CHECKBOX_PROPERTY, 'false');
        checkboxElement.find('.checked-item')
                       .attr('class', 'unchecked-item');
      }
    });
  });
}

// Select all the items in the table
Table.prototype.selectAllItems = function() {
  var table = this;

  // Mark the "Select All" checkbox
  // Mark every checkbox currently displayed
  $('.checkbox').attr(table.CHECKBOX_PROPERTY, 'true');
  $('.unchecked-item').attr('class', 'checked-item');
}

// Deselect all the items in the table
Table.prototype.deselectAllItems = function() {
  var table = this;

  // Unmark the "Select All" checkbox
  // Unmark every checkbox currently displayed
  $('.checkbox').attr(table.CHECKBOX_PROPERTY, 'false');
  $('.checked-item').attr('class', 'unchecked-item');
}

// Deselect the "Select All" checkbox
Table.prototype.deselectSelectAll = function() {
  // Unmark the "Select All" checkbox
  $(this.selectAll).attr(this.CHECKBOX_PROPERTY, 'false');
  $(this.selectAll + ' .checked-item').attr('class', 'unchecked-item');
}

// Check if a checkbox, given by DOM element, is selected
Table.prototype.isSelected = function(element) {
  var checked = element.attr(this.CHECKBOX_PROPERTY);
  return checked === 'true';
}

$(function() {
  var table = new Table();
});
