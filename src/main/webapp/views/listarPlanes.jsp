<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="libreria.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="cabecera.jsp"%>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>

<style>
.error {
	color: #FF0000;
}
</style>

</head>
<body class="skin-blue sidebar-mini">
	<div class="wrapper">

		<header class="main-header"> <%@ include
			file="barraSuperior.jsp"%> </header>
		<!-- Left side column. contains the logo and sidebar -->
		<aside class="main-sidebar"> <%@ include
			file="barraLateral.jsp"%> <!-- /.sidebar -->
		</aside>

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">


			<!-- Main content -->
			<section class="content">

			<div class="row">
				<div class="col-xs-12">
					<div class="box box-primary">
						<div class="box-header">
							<h3 class="box-title">Lista de Planes de Ejecución</h3>

						</div>
						<!-- /.box-header -->
						<div class="box-body">
							<div class="row">
								<div class="col-sm-3"></div>
								<div class="col-sm-6">
									<table id="listaPlanes"
										class="table table-striped table-bordered table-hover">

										<thead>
											<tr>
												<th width="25px">N°</th>
												<th>Nombre Plan</th>
												<th>Fecha Creación</th>
												<th width="90px"></th>


											</tr>
										</thead>

										<tbody>

											<c:forEach var="listaPlanes" items="${listaPlanes}"
												varStatus="loop">
												<tr>
													<c:set var="index" value="${loop.index}" />
													<c:set var="index" value="${index + 1}" />

													<td><c:out value="${index}"></c:out></td>
													<td><c:out value="${listaPlanes.nombre}"></c:out></td>
													<td><fmt:formatDate pattern="dd-MM-yyyy"
															value="${listaPlanes.fechaCreacion}" /></td>
													<td><a href="#" title="Ver"
														onclick="verPlan(${listaPlanes.idPlanEjecucion});"><i
															class="fa fa-eye fa-lg" style="color: blue"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
														<a href="#" title="Editar"
														onclick="editarPlan(${listaPlanes.idPlanEjecucion});"><i
															class="fa fa-edit fa-lg" style="color: #1CE4D0"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a
														href="#" title="Eliminar"
														onclick="eliminarPlan(${listaPlanes.idPlanEjecucion});"><i
															class="fa fa-trash-o fa-lg" style="color: red"></i></a></td>

												</tr>
											</c:forEach>
										</tbody>

									</table>
								</div>
								<div class="col-sm-3"></div>
							</div>
							<br>

						</div>
						<!-- /.box-body -->
					</div>
					<!-- /.box -->


					<!-- /.box -->
				</div>
				<!-- /.col -->
			</div>


			</section>

			<!-- Modal Ver Plan -->

			<div class="modal fade" id="modalVerPlan" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">

							<h4 class="modal-title" id="myModalLabel">Detalle Plan</h4>
						</div>
						<div class="modal-body">


							<div class="row">

								<div class="box-body">

									<table id="listaActividadesPlan"
										class="table table-striped table-bordered table-hover">

										<thead>
											<tr>
												<th width="25px">N°</th>
												<th>Nombre Actividad</th>
												<th width="150px"></th>


											</tr>
										</thead>
									</table>


								</div>


							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-danger pull-left"
									data-dismiss="modal">Cerrar</button>
							</div>
						</div>
					</div>
				</div>
			</div>


			<!-- Modal Editar Plan -->
			<div class="modal fade" id="modalEditarPlan" tabindex="-1"
				role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">

							<h4 class="modal-title" id="myModalLabel">Editar Plan</h4>
						</div>
						<div class="modal-body">


							<div id="form-editar" class="form-group">


								<label class="col-sm-4 control-label">Nombre Plan</label>
								<div class="col-sm-6">
									<input type="text" class="form-control" id="nombrePlanEditar">
									<span id="errorNombrePlanEditar" class="error"
										style="display: none">Ingrese el nombre del plan</span>
								</div>
								<br> <br> <label class="col-sm-4 control-label">Fecha
									Creación</label>
								<div class="col-sm-6">
									<input type="date" class="form-control"
										id="fechaCreacionEditar"> <span
										id="errorFechaCreacionEditar" class="error"
										style="display: none">Ingrese la fecha de creación del
										plan</span>
								</div>

							</div>

						</div>
						<br> <br>
						<div class="modal-footer">
							<button type="button" class="btn btn-danger pull-left"
								data-dismiss="modal">Cerrar</button>
							<button type="button" class="btn btn-primary pull-right"
								onclick="actualizarPlan();">Actualizar</button>
						</div>
					</div>
				</div>
			</div>

		</div>

		<!-- /.content-wrapper -->

		<footer align="center" class="main-footer"
			style="background-color:#ecf0f5;"> <%@ include
			file="pieDePagina.jsp"%> </footer>

		<div class="control-sidebar-bg"></div>

	</div>
	<%@ include file="scripts.jsp"%>
</body>

<script>

function eliminarPlan(idPlan){
	if(idPlan>0){
		swal({
			  title: "¿Está seguro de eliminar el plan?",
			  text: "Esta acción no podrá ser recuperada",
			  type: "warning",
			  showCancelButton: true,
			  confirmButtonClass: "btn-danger",
			  cancelButtonText: "Cancelar",
			  confirmButtonText: "Si, Eliminar",
			  closeOnConfirm: false
			},
			function(){
					  
			  //Ajax para eliminar
			  $.ajax({
					type : 'POST',
					url : "eliminarPlan",
					dataType : 'json',
					data : {
						idPlan:idPlan
					},
					success : function(data) {
						if(data==true){
							toastr.success("Plan eliminado correctamente");
							swal.close();
							
							//Recargar tabla
							//Actualizar el data table
							 $.ajax({
									type : 'POST',
									url : "obtenerListaPlanes",
									dataType : 'json',
									success : function(data) {
										
										if(!$.isEmptyObject(data)){
											//vaciar datatable
											var oTable = $('#listaPlanes').dataTable();
											oTable.fnClearTable();
											
											//Llenar data table
											for(var i=0;i<data.length;i++){
												
												//Formatear fechas
												var fecha = moment(data[i].fechaCreacion,'YYYY/MM/DD');
												fechaCreacion = fecha.format('DD-MM-YYYY');
												
												$('#listaPlanes').dataTable().fnAddData(

														[i + 1, data[i].nombre,fechaCreacion, '<a href="#" title="Ver" onclick="verPlan('+data[i].idPlanEjecucion+');"><i class="fa fa-eye fa-lg" style="color: blue"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="#" onclick="editarPlan('+data[i].idPlanEjecucion+');"><i class="fa fa-edit fa-lg" style="color: #1CE4D0"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" onclick="eliminarPlan('+data[i].idPlanEjecucion+');"><i class="fa fa-trash-o fa-lg" style="color: red"></i></a>' ]

												);
											}
										}
										

									},
									error : function(jqXHR, errorThrown) {
										toastr.error("Error al obtener los insumos");
									}
								});

						}else{
							toastr.error("Error al eliminar el plan");
						}

					},
					error : function(jqXHR, errorThrown) {
						toastr.error("Error al eliminar el plan");
					}
				});
			  
			});
	}
}

function verPlan(idPlan){
	console.log(idPlan);
	if(idPlan>0){
		$.ajax({
			type : 'POST',
			url : "obtenerActividadesPlan",
			dataType : 'json',
			data:{
				idPlan: idPlan
			},
			success : function(data) {
				console.log(data);
				$('#modalVerPlan').modal('show');
				if(!$.isEmptyObject(data)){
					//vaciar datatable
					var oTable = $('#listaActividadesPlan').dataTable();
					oTable.fnClearTable();
					
					//Llenar data table
					for(var i=0;i<data.length;i++){
						$('#listaActividadesPlan').dataTable().fnAddData(

								[i + 1, data[i].nombre,  '<a href="#" onclick="editarActividad('+data[i].idActividad+');"><i class="fa fa-edit fa-lg" style="color: #1CE4D0"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" onclick="eliminarActividad('+data[i].idActividad+');"><i class="fa fa-trash-o fa-lg" style="color: red"></i></a>' ]

						);
					}
				}
				
				//Close modal
				$('#modalEditarInsumo').modal('hide');
				
			},
			error : function(jqXHR, errorThrown) {
				alert("Error al obtener las actividades del plan");
			}
		});
	}
}


function editarPlan(idPlan){
	
	document.getElementById('errorNombrePlanEditar').style.display = 'none';
	document.getElementById('nombrePlanEditar').style.border = "";
	
	document.getElementById('errorFechaCreacionEditar').style.display = 'none';
	document.getElementById('fechaCreacionEditar').style.border = "";
	
	if(idPlan>0){
		//Obtener los datos del plan
		$.ajax({
			type : 'POST',
			url : "obtenerDatosPlan",
			dataType : 'json',
			data:{
				idPlan:idPlan
			},
			success : function(data) {
				console.log(data);
				if(!$.isEmptyObject(data)){
					
					//Cargar los datos en el modal
					$('#nombrePlanEditar').val(data.nombre);
				
					$('#fechaCreacionEditar').val(data.fechaCreacion);
					
					localStorage.setItem("idPlan", idPlan);
					
					//Abrir modal
					$('#modalEditarPlan').modal('show');
					
					
				}
			},
			error : function(jqXHR, errorThrown) {
				alert("Error al obtener los datos del plan seleccionado");
			}
		});
	}
}

function actualizarPlan(){
	var nombre=$('#nombrePlanEditar').val();
	var fecha=$('#fechaCreacionEditar').val();
	
	if(nombre==""){
		document.getElementById('errorNombrePlanEditar').style.display = 'inline';
		document.getElementById('nombrePlanEditar').style.border = "1px solid red";
	}else{
		document.getElementById('errorNombrePlanEditar').style.display = 'none';
		document.getElementById('nombrePlanEditar').style.border = "";
	}
	
	if(fecha==""){
		document.getElementById('errorFechaCreacionEditar').style.display = 'inline';
		document.getElementById('fechaCreacionEditar').style.border = "1px solid red";
	}else{
		document.getElementById('errorFechaCreacionEditar').style.display = 'none';
		document.getElementById('fechaCreacionEditar').style.border = "";
	}
	
	if(nombre!="" && fecha!=""){
		$.ajax({
			type : 'POST',
			url : "actualizarDatosPlan",
			dataType : 'json',
			data:{
				idPlan: localStorage.getItem("idPlan"),
				nombre:nombre,
				fecha:fecha
			},
			success : function(data) {
				console.log(data);
				if(data==true){
					
					//Actualizar Tabla
					$.ajax({
						type : 'POST',
						url : "obtenerListaPlanes",
						dataType : 'json',
						success : function(data) {
							console.log(data);
							if(!$.isEmptyObject(data)){
								//vaciar datatable
								var oTable = $('#listaPlanes').dataTable();
								oTable.fnClearTable();
								
								//Llenar data table
								for(var i=0;i<data.length;i++){
									
									//Formatear fechas
									var fecha = moment(data[i].fechaCreacion,'YYYY/MM/DD');
									fecha = fecha.format('DD-MM-YYYY');
																	
										$('#listaPlanes').dataTable().fnAddData(

												[i + 1, data[i].nombre, fecha, '<a href="#" title="Ver" onclick="verPlan('+data[i].idPlanEjecucion+');"><i class="fa fa-eye fa-lg" style="color: blue"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="#" title="Editar" onclick="editarPlan('+data[i].idPlanEjecucion+');"><i class="fa fa-edit fa-lg" style="color: #1CE4D0"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" title="Eliminar" onclick="eliminarPlan('+data[i].idPlanEjecucion+');"><i class="fa fa-trash-o fa-lg" style="color: red"></i></a>'  ]

										);
									
								}
								
								$('#modalEditarPlan').modal('hide');
								
							}
						},
						error : function(jqXHR, errorThrown) {
							alert("Error al obtener los productos");
						}
					});
					
					
					toastr.success("Plan editado correctamente");
				}else{
					toastr.error("Error al editar el plan");
				}
			},
			error : function(jqXHR, errorThrown) {
				alert("Error al obtener los productos");
			}
		});
	}
}


</script>

<script>
	$('#listaPlanes').DataTable({
		'dom' : 'Bfrtip',
		'paging' : true,
		'lengthChange' : true,
		'searching' : false,
		'ordering' : false,
		'info' : true,
		'autoWidth' : true,
		'responsive' : true,
		"language" : {
			"sProcessing" : "Procesando...",
			"sLengthMenu" : "Mostrar _MENU_ registros",
			"sZeroRecords" : "No se encontraron resultados",
			"sEmptyTable" : "Ningún dato disponible en esta tabla",
			"sInfo" : "",
			"sInfoEmpty" : "No hay datos para mostrar",
			"sInfoFiltered" : "(filtrado de un total de _MAX_ registros)",
			"sInfoPostFix" : "",
			"sSearch" : "Buscar:",
			"sUrl" : "",
			"sInfoThousands" : ",",
			"sLoadingRecords" : "Cargando...",
			"oPaginate" : {
				"sFirst" : "Primero",
				"sLast" : "Último",
				"sNext" : "Siguiente",
				"sPrevious" : "Anterior"
			}
		}
	})
</script>

<script>
	$('#listaActividadesPlan').DataTable({
		'dom' : 'Bfrtip',
		'paging' : true,
		'lengthChange' : true,
		'searching' : false,
		'ordering' : false,
		'info' : true,
		'autoWidth' : true,
		'responsive' : true,
		"language" : {
			"sProcessing" : "Procesando...",
			"sLengthMenu" : "Mostrar _MENU_ registros",
			"sZeroRecords" : "No se encontraron resultados",
			"sEmptyTable" : "Ningún dato disponible en esta tabla",
			"sInfo" : "",
			"sInfoEmpty" : "No hay datos para mostrar",
			"sInfoFiltered" : "(filtrado de un total de _MAX_ registros)",
			"sInfoPostFix" : "",
			"sSearch" : "Buscar:",
			"sUrl" : "",
			"sInfoThousands" : ",",
			"sLoadingRecords" : "Cargando...",
			"oPaginate" : {
				"sFirst" : "Primero",
				"sLast" : "Último",
				"sNext" : "Siguiente",
				"sPrevious" : "Anterior"
			}
		}
	})
</script>

</html>