// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require dataTables/jquery.dataTables
//= require_tree

    function retrivePaginatedDataoFPrevious(table_rows, next_table_rows, 
                                        id, table_identifier, table_counts) {
      
      disable_previous_button(table_identifier);

      var table_data = document.getElementById(id);
      var table_row_count = table_rows.length;
      var next_table_rows_count = next_table_rows.length;
      var markup;
      
      table_id = table_ternary_condition(table_identifier, '');

      status = deleteTableRows(table_id, table_row_count, 
                               next_table_rows_count, 
                               table_counts, 'previous');

      if (status) {
        if (id == table_id) {
          for (var i = 0; i <= table_row_count - 1; i++) {
            condition1 = checkTableCondition1();
            condition2 = checkTableCondition2();
            condition3 = checkTableCondition3();
            
            if (condition1) {
              markup = "<tr> <td>" + table_rows[i][0] +
                       "</td><td>" + table_rows[i][1] +
                       "</td><td>"  + table_rows[i][2] +
                       "</td></tr>" ;
            }
            else if (condition2) {
              markup = "<tr> <td>" + table_rows[i][0] +
                       "</td><td>" + table_rows[i][1] +
                       "</td></tr>" ;
            }
            else if (condition3) {
              markup = "<tr> <td>" + table_rows[i][0] +
                       "</td><td>" + table_rows[i][1] +
                        "</td><td>" + table_rows[i][2] +
                       "</td><td>" + table_rows[i][3] +
                       "</td></tr>" ;
            }
            $(table_data).append(markup);
          }
        }
      }
    }

    function retrivePaginatedDataoFNext(next_table_rows, previous_table_rows, 
                                        id, table_identifier,
                                        table_counts) {

      disable_next_button(table_identifier);

      var table_data = document.getElementById(id);
      var table_row_count = next_table_rows.length;
      var previous_table_row_count = previous_table_rows.length;
      var markup;

      table_id = table_ternary_condition(table_identifier, '');

      status = deleteTableRows(table_id, table_row_count, 
                               previous_table_row_count, table_counts, 
                               'next');
      
      if (status) {
        if (id == table_id) {
          for (var i = 0; i <= table_row_count - 1; i++) {
            condition1 = checkTableCondition1();
            condition2 = checkTableCondition2();
            condition3 = checkTableCondition3();
            
            if (condition1) {
              markup = "<tr> <td>" + next_table_rows[i][0] + 
                       "</td><td>" + next_table_rows[i][1] + 
                       "</td><td>"  + next_table_rows[i][2] +
                       "</td></tr>" ;
            }
            else if (condition2) {
              markup = "<tr> <td>" + next_table_rows[i][0] + 
                       "</td><td>" + next_table_rows[i][1] +  
                       "</td></tr>" ;
            }
            else if (condition3) {
              markup = "<tr> <td>" +  next_table_rows[i][0] +
                       "</td><td>" + next_table_rows[i][1] +
                        "</td><td>" + next_table_rows[i][2] +
                       "</td><td>" + next_table_rows[i][3] +
                       "</td></tr>" ;
            }
            $(table_data).append(markup);
          }
        }
      }
    }

    function disable_next_button(table_identifier) {
      var table_id = table_ternary_condition(table_identifier,
                                          'disable_next_button');

      switch(table_id) {
        case 'project_search_table_details':
            $("#next_data_1").hide();
            $("#previous_data_1").show();
            break;
        case 'task_search_table_details':
            $("#next_data_2").hide();
            $("#previous_data_2").show();
            break;
        case 'user_search_table_details':
            $("#next_data_3").hide();
            $("#previous_data_3").show();
            break;
        case 'employee_details_search_table_data':
            $("#next_data_4").hide();
            $("#previous_data_4").show();
            break;
        default:
            console.log('Button did not change');
      }
    }

    function disable_previous_button(table_identifier) {
      var table_id = table_ternary_condition(table_identifier, 
                                          'disable_previous_button');

      switch(table_id) {
        case 'project_search_table_details':
            $("#next_data_1").show();
            $("#previous_data_1").hide();
            break;
        case 'task_search_table_details':
            $("#next_data_2").show();
            $("#previous_data_2").hide();
            break;
        case 'user_search_table_details':
            $("#next_data_3").show();
            $("#previous_data_3").hide();
        case 'employee_details_search_table_data':
            $("#next_data_4").hide();
            $("#previous_data_4").show();
            break;
        default:
            console.log('Button didnot change');
      }
    }

    function checkTableCondition1() {

      return ( (table_id == 'project_search_table_details') ||
        (table_id ==  'user_search_table_details')
      )
    }

    function checkTableCondition2() {

      return (table_id == 'task_search_table_details')
    }

    function checkTableCondition3() {

      return (table_id == 'employee_details_search_table_data')
    }

    function table_ternary_condition(table_identifier,
                                     method_name) {
      if ( (method_name == 'disable_next_button') || 
           (method_name == 'disable_previous_button') ) {
        debugger;
        return table_indentifier(table_identifier);
      }
      else if (method_name == '') {
        return table_indentifier(table_identifier);
      }
    }

    function table_indentifier(table_identifier){
      return ( (table_identifier == '1') ?
              'project_search_table_details' :
              ( (table_identifier == '2') ?
              'task_search_table_details' :
              ((table_identifier == '3') ?
              'user_search_table_details' :
              'employee_details_search_table_data')) )
    }

    function deleteTableRows(table_id, table_row_count,
                             next_or_previous_table_row_count, table_counts, 
                             pagination_tag_name) {

      var tableHeaderRowCount = 1;
      var table = document.getElementById(table_id);
      var row_condition;

      conditon = row_conditon(table_id, 
                              next_or_previous_table_row_count,
                              pagination_tag_name);
      
      for (var i = tableHeaderRowCount; i <= conditon; i++) {
        table.deleteRow(tableHeaderRowCount);
      }
      return true;
    }

    function return_row_conditon_value(pagination_tag_name,
                                       next_or_previous_table_row_count) {

      if (pagination_tag_name == 'previous') {
        return (next_or_previous_table_row_count);
      }
      else if (pagination_tag_name == 'next') {
        return (next_or_previous_table_row_count);
      }
    }

    function row_conditon(table_id, next_or_previous_table_row_count,
                          pagination_tag_name) {

      switch(table_id) {
        case 'project_search_table_details':
          return (return_row_conditon_value(pagination_tag_name,
                                    next_or_previous_table_row_count))
          break;
        case 'task_search_table_details':
          return (return_row_conditon_value(pagination_tag_name,
                                    next_or_previous_table_row_count))
          break;
        case 'user_search_table_details':
          return (return_row_conditon_value(pagination_tag_name,
                                    next_or_previous_table_row_count))
          break;
        case 'employee_details_search_table_data':
          return (return_row_conditon_value(pagination_tag_name,
                                    next_or_previous_table_row_count))
          break;
        default:
          console.log("could'nt find row condition");
     }
    }