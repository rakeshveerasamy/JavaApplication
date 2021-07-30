<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <!DOCTYPE html>
    <html>

    <head>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
        
       
 <script>
        $(document).ready(function(){
        	$.ajax({
        		url:"rowCountServlet",
        		type:"GET",
        		success:function(result)
        		{
        			console.log(result);
        			$('#row_length').val(Number(result));
        		}
        	});
        	var upper = $("#entries_select").val();
        	if(upper=="-1")
        		{
        		upper = $('#row_length').val();
        		}
        	$.ajax({
                url: "studentListServlet",
                type: "POST",
                data :{
                	  sort:"student.name",
                	  order:"asc",
                	  lower_index :0,
                	  upper_index : upper
                },
                success: function(result) {
                    var output = "";
                    $.each(result, function(key, value) {
                        output += "<tr>" +
                            "<td>" + value.NAME + "</td>" +
                            "<td>" + value.ROLLNO + "</td>" +
                            "<td>" + value.DEPARTMENT + "</td>" +
                            "<td>" + value.COURSE + "</td>" +
                            "<td>" + value.INSTRUCTOR + "</td>"
                    });
                    $(".table-body").html(output);
                    var entries = $("#entries_select").val();
                    getPagination("#courseStudent_table",entries);   
                }
            });
            $.ajax({
                url: "subjectDetailsServlet",
                type: "GET",
                success: function(result) {
                    var output = "";
                    $.each(result, function(key, value) {
                        output += "<option value='" + value.COURSE_ID + "'>" +
                            value.COURSE_NAME + "</option>"
                    });
                    $("#sel").html(output);
                }
            });  
        });
            function signout() {
                window.location.href = "StudentLogoutServlet";
            }

            function add() {
                $(".table-body").html("");
            	var upper = $("#entries_select").val();
            	if(upper=="-1")
            		{
            		upper = $('#row_length').val();
            		}
                $.ajax({
                    url: "studentListServlet",
                    type: "POST",
                    data :{
                  	  sort:$("#sort_column").val(),
                  	  order:$("#sort_order").val(),
                  	  lower_index :0,
               	      upper_index :upper 
                    },
                    success: function(result) {
                        var output = "";
                        $.each(result, function(key, value) {
                            output += "<tr>" +
                                "<td>" + value.NAME + "</td>" +
                                "<td>" + value.ROLLNO + "</td>" +
                                "<td>" + value.DEPARTMENT + "</td>" +
                                "<td>" + value.COURSE + "</td>" +
                                "<td>" + value.INSTRUCTOR + "</td>"
                        });
                        $(".table-body").html(output);
                    }
                });
            }

            function search() {
            	var upper = $("#entries_select").val();
            	if(upper=="-1")
            		{
            		upper = $('#row_length').val();
            		}
                var ele = document.getElementById('search').value;
                $.post('searchServlet', { data: ele }, 
                		function(result) {
                    if (result != null) {
                        var output = "";
                        $.each(result, function(key, value) {
                            output += "<tr>" +
                                "<td>" + value.NAME + "</td>" +
                                "<td>" + value.ROLLNO + "</td>" +
                                "<td>" + value.DEPARTMENT + "</td>" +
                                "<td>" + value.COURSE + "</td>" +
                                "<td>" + value.INSTRUCTOR + "</td>"
                        });
                        $(".table-body").html(output);
                    } else {
                        $(".table-body").html("<br/>No Matching Records Found<br/>");
                    }
                });
            }

            function clearInsert() {
            	$("#alertmsg").css('display','none');
                $("#rollno").val("");
                $("#name").val("");
                $("#phoneno").val("");
                $("#emailid").val("");
                $('#department').val("");
                $('#sel').val("");
            }

            function validate() {
            	$("#alertmsg").css('display','none');
                $("#studentconfirm").css('display','none');
                var rollnumber = $("#rollno").val();
                var name = $("#name").val();
                var phoneno = $("#phoneno").val();
                var emailid = $("#emailid").val();
                var dept = $('#department').val();
                var sel = $('#sel').val();
                if(rollnumber!=""&&name!=""&&phoneno!=""&&emailid!=""&&dept!=""&&sel!="")
                	{
                	dataInsert();
                	}
                else
                	{
                    $("#studentconfirm").css('display','none');
                	$("#alertmsg").html("Entries can't be Empty").css('display','block');
                	}
            }
            function dataInsert() {
                var rollnumber = $("#rollno").val();
                var name = $("#name").val();
                var dept = $('#department').val();
                var sel = $('#sel').val();
                var sendInfo = {
                        rollnumber: rollnumber,
                        name: name,
                        dept: dept,
                        subject: sel
                    };
                $.ajax({
                    url: "insertStudentServlet",
                    type: "POST",
                    data: sendInfo,
                    success: function(result) {
                    	$("#alertmsg").css('display','none');
                        $("#studentconfirm").html(" Data inserted Successfully<br/>").css('display','block');
                        add();
                    }
                });
                $.ajax({
            		url:"rowCountServlet",
            		type:"GET",
            		success:function(result)
            		{
            			console.log(result);
            			$('#row_length').val(Number(result));
            		}
            	});
                clearInsert();
            }

            function clearSubject() {
            	$("#subalertmsg").css('display','none');
                $("#subjectid").val("");
                $("#subjectname").val("");
                $('#subjectdept').val("");
                $('#instructor').val("");
            }
            function validateSubject()
            {
            	$("#subalertmsg").css('display','none');
                $("#subjectconfirm").css('display','none');
            	var id = $("#subjectid").val();
                var name = $("#subjectname").val();
                var dept = $('#subjectdept').val();
                var instructor = $('#instructor').val();
                if(id!=""&&name!=""&&dept!=""&&instructor!="")
                	{
                	subjectInsert();
                	}
                else
                	{
                    $("#subjectconfirm").addClass("disable").removeClass("active");
                	$("#subalertmsg").html("Entries can't be Empty").addClass("active").removeClass("disable");;
                	}
            }
            function subjectInsert() {
                var id = $("#subjectid").val();
                var name = $("#subjectname").val();
                var dept = $('#subjectdept').val();
                var instructor = $('#instructor').val();
                $.ajax({
                    url: "insertSubjectServlet",
                    type: "POST",
                    data: {
                        id: id,
                        name: name,
                        dept: dept,
                        instructor: instructor
                    },
                    success: function(result) {
                    	$("#subalertmsg").css('display','none');
                        $("#subjectconfirm").html(" Data inserted Successfully <br/>").css('display','block');
                        var output = "";
                        $.each(result, function(key, value) {
                            output += "<option value='" + value.COURSE_ID + "'>" +
                                value.COURSE_NAME + "</option>";
                        });
                        $("#sel").append(output);
                    }
                });
                clearSubject();
            }
            function getPagination(table, maxRows) {
                $('.paginationgalley').html('');
                var currentIndex;
                var totalpagenum;
                var totalRows = $('#row_length').val();
                if (true) {
                    totalpagenum = Math.ceil(totalRows / maxRows);
                    
                    $('.paginationgalley').append('<button data-page="prev" class=" btn btn-info  disable" id="go-prev">Prev</button>').show();
                    for (var i = 1; i <= totalpagenum;) {
                        $('.paginationgalley').append('<button class="btn btn-light page-' + i + '" data-page=' + i + '>' + i++ +'</button>').show();
                    }
                    $('.paginationgalley').append('<button data-page="next" class=" btn btn-info  transform-rotate" id="go-next">Next</button>').show();

                }
                showig_rows_count(maxRows, 1, totalRows);
                $('.paginationgalley button').on('click', function (e) {
                    e.preventDefault();
                    var pageNum;
                    if ($(this).attr('data-page') != 'prev' && $(this).attr('data-page') != 'next') {
                        pageNum = parseInt($(this).attr('data-page'));
                    } else {
                        pageNum = $(this).attr('data-page');
                    }

                    if (pageNum == 'prev' ) {
                        pageNum = --currentIndex;
                    } else if (pageNum == 'next' ) {
                        pageNum = ++currentIndex;
                    }
                    var trIndex = 0;
                    $('.paginationgalley button').removeClass('active');
                    if (pageNum == 1) {
                        $(this).parent().find('#go-prev').addClass('disable');
                    } 
                    else { 
                    	$(this).parent().find('#go-prev').removeClass('disable');
                    	}
                    if (pageNum == totalpagenum) {
                        $(this).parent().find('#go-next').addClass('disable');
                    } 
                    else { 
                    	$(this).parent().find('#go-next').removeClass('disable'); 
                    	}
                    currentIndex = pageNum;
                    showig_rows_count(maxRows, pageNum, totalRows);
                    
                });
            }
            function showig_rows_count(maxRows, pageNum, totalRows) {
                var end_index = maxRows * pageNum;
                if(end_index == -1)
                	{
                	 end_index = totalRows;
                	}
                var start_index = ((maxRows * pageNum) - maxRows) + parseFloat(1);
                var string = 'Showing ' + start_index + ' to ' + end_index + ' of ' + totalRows + ' entries';
                $(".table-body").html("");
                var upper = $("#entries_select").val();
            	if(upper=="-1")
            		{
            		upper = $('#row_length').val();
            		}
                $.ajax({
                    url: "studentListServlet",
                    type: "POST",
                    data :{
                  	  sort:$("#sort_column").val(),
                  	  order:$("#sort_order").val(),
                  	  lower_index :start_index-1,
               	      upper_index :upper
                    },
                    success: function(result) {
                        var output = "";
                        $.each(result, function(key, value) {
                            output += "<tr>" +
                                "<td>" + value.NAME + "</td>" +
                                "<td>" + value.ROLLNO + "</td>" +
                                "<td>" + value.DEPARTMENT + "</td>" +
                                "<td>" + value.COURSE + "</td>" +
                                "<td>" + value.INSTRUCTOR + "</td>"
                        });
                        $(".table-body").html(output);
                    }
                });
                $('.rows_count').html(string);
            }
        </script>
        <style>
             html,body {
			     height:100%;
			     width:100%;
			     margin:0;
			}
			th{
			  color:white
			}
            .insert-container {
                max-width: 800px;
                margin: auto;
               
            }
            #sort_label
            {
              color:white;
            }
            li
            {
              padding:0px 3px;
            }
            .disable
            {
              pointer-events:none;
              opacity:0.6;
            }
        </style>
    </head>

    <body>
        <div class="insert-container">
          <div class = "table_div">
            <h2 style="color:blue; text-align:center;" class = "my-5">Student Elective Choosing Forum</h2>
            <div style ="display:flex; justify-content:space-between;">
               <div style ="display:flex">
                <label style ="display:flex; align-items:center">
                  Show
	                  <select class="form-select form-select-sm" id= "entries_select" style = "display:inline-block" onchange = "getPagination('#courseStudent_table',this.value)">
	                  	<option value = "5">5</option>
	                  	<option value = "10">10</option>
	                  	<option value = "25">25</option>
	                  	<option value = "50">50</option>
	                  	<option value = "-1">All</option>
	                  </select>
	               Entries
                 </label> 
                <button  type="button" id="sort_button" data-bs-toggle="modal" data-bs-target="#sortby_modal" class="mx-2 btn btn-primary ">Sort By</button>
				</div>
                <div >
                    <label for="search">Search</label>
                    <input  id="search" name="search" placeholder="Enter for search" onInput="search()" required/>
                </div>
            </div>
            <div align="right">
                <input type = "hidden" id = "row_length"/>
                <table id="courseStudent_table"  class="table table-striped mt-3" >
                    <thead class="bg-primary">
                        <tr>
                            <th>Name</th>
                            <th>Roll No</th>
                            <th>Department</th>
                            <th>Subject</th>
                            <th>Instructor</th>
                        </tr>
                    </thead>
                    <tbody class="table-body">
                    </tbody>
                </table>
                 <div style = "display: flex;justify-content: space-between;">
	                 <span class = "rows_count"></span>
					 <div class='header_wrap pagination-container'>
					      <nav>
					         <div class="paginationgalley pagination"></div>
					       </nav>
					  </div>		             
	             </div>
                <div align="right" class = "mt-3">
                    <button type="button" id="insertStudent_button" data-bs-toggle="modal" data-bs-target="#insertStudent" class="btn btn-success">Insert</button>
                    <button type="button" id="addSubject_button" data-bs-toggle="modal" data-bs-target="#addSubject" class="btn btn-success">Add Subject</button>
                </div>
                <div align="center">
                    <button type="button" id="signout_button" class="btn btn-warning" onclick="signout()">Sign Out</button>
                </div>
            </div>
           </div>
           
            <div id="insertStudent" class="modal" tabindex="-1">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
							<h4 class="modal-title">Insert Student Elective</h4>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						</div>
                        <div class="modal-body">
                            <form id="student_form" method="post">
                                <div class = "col-md-12 mb-3">
                                         <div style="color:green" id="studentconfirm"></div>
                                         <div style="color:red" id="alertmsg"></div>
                                         
		                        </div>
                                <div class="col-md-12 mb-3">
                                    <label for="rollno">Roll Number : </label>
                                    <input type="number" name="rollno" id="rollno" autocomplete = "off"class="form-control" placeholder="Enter your Roll Number" required/>
                                </div>
                                <div class="col-md-12 mb-3">
                                    <label for="name">Name : </label>
                                    <input type="text" name="name" id="name" autocomplete="off" class="form-control" placeholder="Enter your Name" required/>
                                </div>
                                <div class="col-md-12 mb-3">
                                    <label for="email">Email Id : </label>
                                    <input type="email" name="emailid" id="emailid" autocomplete = "off"class="form-control" placeholder="Enter your Email Id" required/>
                                </div>
                                <div class="col-md-12 mb-3">
                                    <label for="phoneno">Phone Number : </label>
                                    <input type="tel" name="phoneno" id="phoneno" autocomplete = "off" class="form-control" placeholder="Enter your Phone Number" required/>
                                </div>
                                <div class="col-md-12 mb-3">
                                    <label for="department">Department : </label>
                                    <input type="text" name="department" id="department" autocomplete="off" class="form-control" placeholder="Enter your Department" required/>
                                </div>
                                <div class="col-md-12 mb-3">
                                    <label for="instructor">Subject :</label>
                                    <select id="sel" name="instructor">
						                <option value = "">----Select----</option>
						            </select>
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="submit" form="student_form" name="insert" id="insertDataButton" class="btn btn-primary" onclick="validate()">Insert</button>
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
              
            <div id="addSubject" class="modal" tabindex = "-1">
                <div class="modal-dialog">
                        <div class="modal-content">
	                        <div class="modal-header">
									<h4 class="modal-title">Subject</h4>
		                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
							    </div>
	                        <div class="modal-body">
	                            <form class="requires-validation" id="subject_form" method="post">
	                                <div class = "col-md-12 mb-3">
		                            	<div style="color:green" id="subjectconfirm"></div>
		                            	<div style="color:red" id="subalertmsg"></div>
		                            	
		                            </div>
		                            <div class = "col-md-12 mb-3">
			                            <label for="subjectid">Subject Id : </label>
			                            <input type="number" name="subjectid" id="subjectid" autocomplete="off" class="form-control" placeholder="Enter Subject Id" required/><br>
		                                <div class="invalid-feedback">Subject Id field cannot be blank!</div>
		                            </div>
		                            <div class= "col-md-12 mb-3">
			                            <label for="subjectname">Subject Name : </label>
			                            <input type="text" name="subjectname" id="subjectname" autocomplete="off" class="form-control" placeholder="Enter Subject Name" required/><br>
		                                <div class="invalid-feedback">Subject Name field cannot be blank!</div>
		                            </div>
		                            <div class = "col-md-12 mb-3">
			                            <label for="subjectdept">Subject Department : </label>
			                            <input type="text" name="subjectdept" id="subjectdept" autocomplete="off" class="form-control" placeholder="Enter Subject Department" required/><br>
		                                <div class="invalid-feedback">Subject Department field cannot be blank!</div>
		                            </div>
		                            <div class = "col-md-12 mb-3">
			                            <label for="instructor">Instructor : </label>
			                            <input type="text" name="instructor" id="instructor" autocomplete="off" class="form-control" placeholder="Enter Instructor Name" required/><br>
		                                <div class="invalid-feedback">Instructor field cannot be blank!</div>
	                                </div>
	                            </form>
	                        </div>
	                        <div class="modal-footer">
                            <button name="add"  form ="subject_form" id="subjectDataButton" class="btn btn-primary" onclick="validateSubject()">Add Subject</button>
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        </div>
                        </div>
                </div>
            </div>
             <div id = "sortby_modal" class="modal fade bd-example-modal-sm" tabindex="-1" >
  					<div class="modal-dialog modal-sm">
  						<div class="modal-content">
	                        <div class="modal-header">
	                                <h4 class="modal-title text-primary">Sorting</h4>
		                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
							    </div>
	                        <div class="modal-body">
		                           <label class="font-weight-bold  text-primary">
		                           Sort by
		                             <select id = "sort_column" >
		                             	<option value = "student.name">Name</option>
		                             	<option value = "student.rollno">Roll No</option>
		                             	<option value = "student.dept">Department</option>
		                             	<option value = "course.course_name">Subject</option>
		                             	<option value = "course.instructor">Instructor</option>
		                             </select>
		                            In
		                             <select id = "sort_order">
		                             	<option value = "asc">Asc</option>
		                             	<option value = "desc">Desc</option>
		                             </select>
		                           </label>
	                        </div>
	                        <div class="modal-footer">
	                            <button name="add"   id="sortDataButton" class="btn btn-primary" onclick= "add()" >Apply</button>
	                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            </div>
                        </div>
  						
  					</div>
  			 </div>
        </div>
    </body>

    </html>