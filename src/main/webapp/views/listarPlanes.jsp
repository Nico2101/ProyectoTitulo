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
							<h3 class="box-title">Lista de Planes</h3>

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

							<h4 class="modal-title" id="tituloPlan"></h4>
							<button id="agregarActividad" type="button"
								class="btn btn-primary pull-right"
								onclick="modalAgregarActividad();">
								<i class="fa fa-plus-circle"> Agregar Actividad</i>
							</button>
						</div>
						<div class="modal-body">

							<p>Nota: Para actualizar el orden de las actividades debe
								seleccionar el número y arrastrarlo a la posición que desee</p>
							<div class="row">

								<div class="box-body">

									<table id="listaActividadesPlan"
										class="table table-striped table-bordered table-hover"
										width="100%">

										<thead>
											<tr>
												<th width="25px">N°</th>
												<th>Nombre Actividad</th>
												<th width="150px"></th>
												<th width="10px"></th>

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


								<label class="col-sm-4 control-label">* Nombre Plan</label>
								<div class="col-sm-6">
									<input type="text" class="form-control" id="nombrePlanEditar">
									<span id="errorNombrePlanEditar" class="error"
										style="display: none">Ingrese el nombre del plan</span>
								</div>
								<br> <br> <label class="col-sm-4 control-label">*
									Fecha Creación</label>
								<div class="col-sm-6">
									<input type="date" class="form-control"
										id="fechaCreacionEditar"> <span
										id="errorFechaCreacionEditar" class="error"
										style="display: none">Ingrese la fecha de creación del
										plan</span> <span id="errorFechaCreacionEditarMayor" class="error"
										style="display: none">La fecha no puede ser futura</span>
								</div>
								<br> <br> <br> <label
									class="col-sm-4 control-label"></label>
								<div class="col-sm-6">
									<label class="pull-right"
										style="font-weight: normal; color: red">* Campos
										obligatorios</label>
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


			<!-- Modal Editar Actividad -->
			<div class="modal fade" id="modalEditarActividad" tabindex="-1"
				role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">

							<h4 class="modal-title" id="myModalLabel">Editar Actividad</h4>

						</div>
						<div class="modal-body">


							<div id="form-editar" class="form-group">


								<label class="col-sm-4 control-label">* Nombre Actividad</label>
								<div class="col-sm-6">
									<input type="text" class="form-control"
										id="nombreActividadEditar"> <span
										id="errorNombreActividadEditar" class="error"
										style="display: none">Ingrese el nombre de la actividad</span>
								</div>

								<br> <br> <br> <label
									class="col-sm-4 control-label"></label>
								<div class="col-sm-8">
									<input type="checkbox" class="" id="checkCosechaEditar">
									Seleccione sólo si la actividad corresponde a cosecha
								</div>

								<br> <br> <br> <label
									class="col-sm-4 control-label"></label>
								<div class="col-sm-6">
									<label class="pull-right"
										style="font-weight: normal; color: red">* Campos
										obligatorios</label>
								</div>

							</div>

						</div>
						<br> <br>
						<div class="modal-footer">
							<button type="button" class="btn btn-danger pull-left"
								data-dismiss="modal">Cerrar</button>
							<button type="button" class="btn btn-primary pull-right"
								onclick="actualizarActividadPlan();">Actualizar</button>
						</div>
					</div>
				</div>
			</div>

			<!-- Modal Agregar Actividad -->
			<div class="modal fade" id="modalAgregarActividad" tabindex="-1"
				role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">

							<h4 class="modal-title" id="myModalLabel">Agregar Actividad</h4>
						</div>
						<div class="modal-body">


							<div class="row">

								<div class="box-body">

									<div id="form-editar" class="form-group">

										<label class="col-sm-4 control-label"
											id="tituloActividadAgregar">* Nombre Actividad</label>
										<div class="col-sm-6">
											<input type="text" class="form-control" id="nombreActividad">
											<span id="errorNombreActividad" class="error"
												style="display: none">Ingrese el nombre de la
												actividad</span>
										</div>

										<br> <br> <br> <label
											class="col-sm-4 control-label"></label>
										<div class="col-sm-8">
											<input type="checkbox" class="" id="checkCosecha">
											Seleccione sólo si la actividad corresponde a cosecha
										</div>

										<br> <br> <br> <label
											class="col-sm-4 control-label"></label>
										<div class="col-sm-6">
											<label class="pull-right"
												style="font-weight: normal; color: red">* Campos
												obligatorios</label>
										</div>

									</div>


								</div>


							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-danger pull-left"
									data-dismiss="modal">Cerrar</button>
								<button id="botonGuardar" type="button" class="btn btn-primary"
									onclick="agregarActividad();">Agregar</button>
							</div>
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
		localStorage.setItem("idPlan", idPlan);
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
					
					$('#tituloPlan').text("Detalle Plan: "+data[0].planEjecucion.nombre);
					
					//vaciar datatable
					var oTable = $('#listaActividadesPlan').dataTable();
					oTable.fnClearTable();
					
					//Llenar data table
					for(var i=0;i<data.length;i++){
						$('#listaActividadesPlan').dataTable().fnAddData(

								[i + 1, data[i].nombre,  '<a href="#" onclick="editarActividad('+data[i].idActividad+');"><i class="fa fa-edit fa-lg" style="color: #1CE4D0"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" onclick="eliminarActividad('+data[i].idActividad+');"><i class="fa fa-trash-o fa-lg" style="color: red"></i></a>',data[i].idActividad ]

						);
					}
				}
				
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
	var fechaActual=new Date();
	var f=moment(fecha,'YYYY/MM/DD');
	if(fecha==""){
		document.getElementById('errorFechaCreacionEditar').style.display = 'inline';
		document.getElementById('fechaCreacionEditar').style.border = "1px solid red";
		document.getElementById('errorFechaCreacionEditarMayor').style.display = 'none';
	}else{
		
		fechaActual = moment(fechaActual,'YYYY/MM/DD');
		fechaActual = fechaActual.format('DD-MM-YYYY');
		
		f=f.format('DD-MM-YYYY');
		
		if(f>fechaActual){
			document.getElementById('errorFechaCreacionEditar').style.display = 'none';
			document.getElementById('errorFechaCreacionEditarMayor').style.display = 'inline';
			document.getElementById('fechaCreacionEditar').style.border = "1px solid red";
		}else{
			document.getElementById('errorFechaCreacionEditar').style.display = 'none';
			document.getElementById('fechaCreacionEditar').style.border = "";
			document.getElementById('errorFechaCreacionEditarMayor').style.display = 'none';
		}
		
	}
	
	if(nombre!="" && fecha!="" && f<=fechaActual){
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
		
		localStorage.removeItem("idPlan");
	}
}

function editarActividad(idActividad){
	
	if(idActividad >0){
		$.ajax({
			type : 'POST',
			url : "obtenerDatosActividad",
			dataType : 'json',
			data:{
				idActividad:idActividad
			},
			success : function(data) {
				console.log(data);
				if(!$.isEmptyObject(data)){
					$('#nombreActividadEditar').val(data.nombre);
					
					if(data.actividadCosecha==true){
						$('#checkCosechaEditar').prop('checked',true);
					}
					
					document.getElementById('errorNombreActividadEditar').style.display = 'none';
					document.getElementById('nombreActividadEditar').style.border = "";
					//mostrar modal
					$('#modalEditarActividad').modal('show');
					
					localStorage.setItem("idActividad", data.idActividad);
				}
			},
			error : function(jqXHR, errorThrown) {
				alert("Error al obtener la actividad");
			}
		});
	}
	
}

function actualizarActividadPlan(){
	
	var idActividad=localStorage.getItem("idActividad");
	
	var nombreActividad=$('#nombreActividadEditar').val();
	
	if (nombreActividad == "") {
		document.getElementById('errorNombreActividadEditar').style.display = 'inline';
		document.getElementById('nombreActividadEditar').style.border = "1px solid red";
	} else {
		document.getElementById('errorNombreActividadEditar').style.display = 'none';
		document.getElementById('nombreActividadEditar').style.border = "";
	}
	
	var check=0;
	if($('#checkCosechaEditar').prop('checked')){
		check=1;
	}
	console.log(check);
	
	if(nombreActividad !="" && idActividad>0){
		$.ajax({
			type : 'POST',
			url : "actualizarActividad",
			dataType : 'json',
			data:{
				idActividad: idActividad,
				nombreActividad: nombreActividad,
				check:check
			},
			success : function(data) {
				console.log(data);
				if(data==true){
					//Actualizar Tabla
					toastr.success("Actividad editada correctamente");
					var idPlan=localStorage.getItem("idPlan");
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
									
									$('#tituloPlan').text("Detalle Plan: "+data[0].planEjecucion.nombre);
									
									//vaciar datatable
									var oTable = $('#listaActividadesPlan').dataTable();
									oTable.fnClearTable();
									
									//Llenar data table
									for(var i=0;i<data.length;i++){
										$('#listaActividadesPlan').dataTable().fnAddData(

												[i + 1, data[i].nombre,  '<a href="#" onclick="editarActividad('+data[i].idActividad+');"><i class="fa fa-edit fa-lg" style="color: #1CE4D0"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" onclick="eliminarActividad('+data[i].idActividad+');"><i class="fa fa-trash-o fa-lg" style="color: red"></i></a>',data[i].idActividad ]

										);
									}
								}
								
								//Close modal
								$('#modalEditarActividad').modal('hide');
								
							},
							error : function(jqXHR, errorThrown) {
								alert("Error al obtener las actividades del plan");
							}
						});
					}
					
					
					
					
				}else{
					toastr.error("Error al editar la actividad");
				}
			},
			error : function(jqXHR, errorThrown) {
				alert("Error al obtener los productos");
			}
		});
	}
	
}

function eliminarActividad (idActividad){
	if(idActividad>0){
		swal({
			  title: "¿Está seguro de eliminar la actividad?",
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
					url : "eliminarActividad",
					dataType : 'json',
					data : {
						idActividad:idActividad
					},
					success : function(data) {
						if(data==true){
							toastr.success("Actividad eliminada correctamente");
							swal.close();
							var idPlan=localStorage.getItem("idPlan");
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
											
											$('#tituloPlan').text("Detalle Plan: "+data[0].planEjecucion.nombre);
											
											//vaciar datatable
											var oTable = $('#listaActividadesPlan').dataTable();
											oTable.fnClearTable();
											
											//Llenar data table
											for(var i=0;i<data.length;i++){
												$('#listaActividadesPlan').dataTable().fnAddData(

														[i + 1, data[i].nombre,  '<a href="#" onclick="editarActividad('+data[i].idActividad+');"><i class="fa fa-edit fa-lg" style="color: #1CE4D0"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" onclick="eliminarActividad('+data[i].idActividad+');"><i class="fa fa-trash-o fa-lg" style="color: red"></i></a>',data[i].idActividad ]

												);
											}
										}
										
										//Close modal
										$('#modalEditarActividad').modal('hide');
										
									},
									error : function(jqXHR, errorThrown) {
										alert("Error al obtener las actividades del plan");
									}
								});
							}
							

						}else{
							toastr.error("Error al eliminar la actividad");
						}

					},
					error : function(jqXHR, errorThrown) {
						toastr.error("Error al eliminar la actividad");
					}
				});
			  
			});
	}
}

function modalAgregarActividad() {
	$('#nombreActividad').val("");
	$('#modalAgregarActividad').modal('show');
	document.getElementById('errorNombreActividad').style.display = 'none';
	document.getElementById('nombreActividad').style.border = "";
	//$('#nombreActividad').focus();
	var table = $('#listaActividadesPlan').DataTable();
	
	var count=table.rows().count()+1;
	
	$('#tituloActividadAgregar').text("Nombre Actividad "+count);
	
	if($('#checkCosecha').prop('checked')){
		$('#checkCosecha').prop('checked',false);
	}
	
}

function agregarActividad(){
	var nombreActividad = $('#nombreActividad').val();
	
	if(nombreActividad==""){
		document.getElementById('errorNombreActividad').style.display = 'inline';
		document.getElementById('nombreActividad').style.border = "1px solid red";
	}else{
		document.getElementById('errorNombreActividad').style.display = 'none';
		document.getElementById('nombreActividad').style.border = "";
	}
	var idPlan=localStorage.getItem("idPlan");
	
	var check=0;
	if($('#checkCosecha').prop('checked')){
		check=1;
	}
	
	//Obtener el orden que le corresponde a la actividad
	var table = $('#listaActividadesPlan').DataTable();
	var orden=table.rows().count()+1;
	
	if(nombreActividad!="" && idPlan>0){
		$.ajax({
			type : 'POST',
			url : "agregarActividad",
			dataType : 'json',
			data:{
				idPlan: idPlan,
				nombreActividad: nombreActividad,
				check:check,
				orden:orden
			},
			success : function(data) {
				console.log(data);
				if(data==true){
					toastr.success("Actividad agregada correctamente");
					$('#modalAgregarActividad').modal('hide');
					
					//Actualizar tabla
					var idPlan=localStorage.getItem("idPlan");
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
									
									$('#tituloPlan').text("Detalle Plan: "+data[0].planEjecucion.nombre);
									
									//vaciar datatable
									var oTable = $('#listaActividadesPlan').dataTable();
									oTable.fnClearTable();
									
									//Llenar data table
									for(var i=0;i<data.length;i++){
										$('#listaActividadesPlan').dataTable().fnAddData(

												[i + 1, data[i].nombre,  '<a href="#" onclick="editarActividad('+data[i].idActividad+');"><i class="fa fa-edit fa-lg" style="color: #1CE4D0"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" onclick="eliminarActividad('+data[i].idActividad+');"><i class="fa fa-trash-o fa-lg" style="color: red"></i></a>',data[i].idActividad ]

										);
									}
								}
								
								//Close modal
								$('#modalEditarActividad').modal('hide');
								
							},
							error : function(jqXHR, errorThrown) {
								alert("Error al obtener las actividades del plan");
							}
						});
					}
				}else{
					toastr.error("Error al agregar la actividad");
				}
			},
			error : function(jqXHR, errorThrown) {
				alert("Error al agregar la actividad");
			}
		});
	}
}


</script>

<script>
var table = $('#listaActividadesPlan').DataTable( {
    rowReorder: true,
    'searching' : false,
    'lengthChange' : false,
    'responsive':true,
    'fnCreatedRow': function (nRow, aData, iDataIndex) {
    	console.log(nRow);
    	console.log(aData);
    	console.log(iDataIndex);
        //$(nRow).attr('id', 'my' + iDataIndex); // or whatever you choose to set as the id
    },
    "columnDefs": [
        {
            "targets": [ 3 ],
            "visible": false,
            "searchable": false
        }
    ],
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
} );
 
table.on( 'row-reorder', function ( e, diff, edit ) {
    for ( var i=0, ien=diff.length ; i<ien ; i++ ) {
        $(diff[i].node).addClass("reordered");
       
    }
    
    //Actualizar bd
    //Obtener todos los valores de un data table
    var table = $('#listaActividadesPlan').DataTable();
    
    var data = table.rows().data();
   
  	var arreglo=Array();
    for(var i=0; i<data.length; i++){
    	for(var j=0;j<diff.length;j++){
    		if(data[i][0]==diff[j].oldData){
        		var posicion=diff[j].newData;
        		var idActividad=data[i][3];
        		
        		arreglo.push(idActividad);
        		arreglo.push(posicion);
        		
        		
        	}
    	}
    	   	
    }
    
    if(arreglo.length>0){
    	console.log(arreglo);
    	$.ajax({
    		type : 'POST',
    		url : "actualizarPosicionActividad",
    		dataType : 'json',
    		async:false,
    		data:{arreglo:arreglo},
    		success : function(data) {
    			if(data==true){
    				toastr.success("Posiciones actualizadas correctamente");
    			}else{
    				toastr.error("Se ha producido un error al actualizar las posiciones");
    			}
    			
    		},
    		error : function(jqXHR, errorThrown) {
    			alert("Error al actualizar la posición");
    		}
    	});
    }
    
} );
	
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

</html>