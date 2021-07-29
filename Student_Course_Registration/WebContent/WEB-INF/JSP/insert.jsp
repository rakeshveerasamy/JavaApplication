<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <!DOCTYPE html>
    <html>

    <head>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.min.js"></script>
        <link href="https://cdn.datatables.net/1.10.25/css/jquery.dataTables.min.css" rel="stylesheet">
       
 <script>
        $(document).ready(function(){
            $.ajax({
                url: "studentListServlet",
                type: "GET",
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
                    $('#courseStudent_table').DataTable({
                    	searching: false,
                    	 ordering: false,
                    	 "lengthMenu": [[-1,5, 10, 25, -1], ["---select---",5, 10, 25, "All"]]
                    });
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
                $.ajax({
                    url: "studentListServlet",
                    type: "POST",
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
                var ele = document.getElementById('search').value;
                $.get('searchServlet', { data: ele }, 
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
                $("#rollno").val("");
                $("#name").val("");
                $("#phoneno").val("");
                $("#emailid").val("");
                $('#department').val("");
                $('#sel').val("");
            }

            function validate() {
                var rollnumber = $("#rollno").val();
                var name = $("#name").val();
                var phoneno = $("#phoneno").val();
                var emailid = $("#emailid").val();
                var dept = $('#department').val();
                var sel = $('#sel').val();
                if(rollnumber!=""&&name!=""&&phoneno!=""&&emailid!=""&&dept!=""&&sel=="")
                	{
                	dataInsert();
                	}
                else
                	{
                	$("#alertmsg").html("Entries can't be Empty");
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
                    type: "GET",
                    //data: sendInfo,
                    headers: sendInfo,
                    success: function(result) {
                        $("#studentconfirm").html(" Data inserted Successfully<br/>");
                        var output = "";
                        $.each(result, function(key, value) {
                            output += "<tr>" +
                                "<td>" + value.NAME + "</td>" +
                                "<td>" + value.ROLLNO + "</td>" +
                                "<td>" + value.DEPARTMENT + "</td>" +
                                "<td>" + value.COURSE + "</td>" +
                                "<td>" + value.INSTRUCTOR + "</td>"
                        });
                        $(".table-body").append(output);
                    }
                });
                clearInsert();
            }

            function clearSubject() {
                $("#subjectid").val("");
                $("#subjectname").val("");
                $('#subjectdept').val("");
                $('#instructor').val("");
            }
            function validateSubject()
            {
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
                	$("#subalertmsg").html("Entries can't be Empty");
                	}
            }
            function subjectInsert() {
                var id = $("#subjectid").val();
                var name = $("#subjectname").val();
                var dept = $('#subjectdept').val();
                var instructor = $('#instructor').val();
                $.ajax({
                    url: "insertSubjectServlet",
                    type: "GET",
                    data: {
                        id: id,
                        name: name,
                        dept: dept,
                        instructor: instructor
                    },
                    success: function(result) {
                        $("#subjectconfirm").html(" Data inserted Successfully <br/>");
                        var output = "";
                        $.each(result, function(key, value) {
                            output += "<option value='" + value.COURSE_ID + "'>" +
                                value.COURSE_NAME + "</option>"
                        });
                        $("#sel").append(output);
                    }
                });
                clearSubject();
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
             
        </style>
    </head>

    <body>
        <div class="insert-container">
          <div class = "table_div">
            <h2 style="color:blue; text-align:center">Student Elective Choosing Forum</h2>
            <div align="right">
                <label for="search">Search</label>
                <input id="search" name="search" placeholder="Enter for search" onInput="search()" required/>
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
                <div align="right" class = "mt-3">
                    <button type="button" id="insertStudent_button" data-bs-toggle="modal" data-bs-target="#insertStudent" class="btn btn-success">Insert</button>
                    <button type="button" id="addSubject_button" data-bs-toggle="modal" data-bs-target="#addSubject" class="btn btn-success">Add Subject</button>
                </div>
                <div align="center">
                    <button type="button" id="signout_button" class="btn btn-success" onclick="signout()">Sign Out</button>
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
                                    <input type="number" name="phoneno" id="phoneno" autocomplete = "off" class="form-control" placeholder="Enter your Phone Number" required/>
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
                            <button type="submit" form="student_form" name="insert" id="insertDataButton" class="btn btn-success" onclick="validate()">Insert</button>
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
                            <button name="add"  form ="subject_form" id="subjectDataButton" class="btn btn-success" onclick="validateSubject()">Add Subject</button>
                        </div>
                        </div>
                </div>
            </div>
            </div>
    </body>

    </html>