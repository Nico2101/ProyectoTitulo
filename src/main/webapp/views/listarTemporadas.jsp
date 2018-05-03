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
							<h3 class="box-title">Lista de Temporadas</h3>
							<button id="agregarInsumo" type="button"
								class="btn btn-primary pull-right" onclick="agregarTemporada();">
								<i class="fa fa-plus-circle"> Agregar Temporada</i>
							</button>

						</div>
						<!-- /.box-header -->
						<div class="box-body">
							<div class="row">

								<div class="col-sm-12">
									<table id="listaTemporadas"
										class="table table-striped table-bordered table-hover">

										<thead>
											<tr>
												<th>N°</th>
												<th>Nombre</th>
												<th>Fecha de inicio</th>
												<th>Fecha de término</th>
												<th>Estado</th>
												<th></th>

											</tr>
										</thead>

										<tbody>

											<c:forEach var="listaTemporadas" items="${listaTemporadas }"
												varStatus="loop">
												<tr>
													<c:set var="index" value="${loop.index}" />
													<c:set var="index" value="${index + 1}" />

													<td><c:out value="${index}"></c:out></td>
													<td><c:out value="${listaTemporadas.nombre}"></c:out></td>
													<td><fmt:formatDate pattern="dd-MM-yyyy"
															value="${listaTemporadas.fechaInicio}" /></td>
													<td><fmt:formatDate pattern="dd-MM-yyyy"
															value="${listaTemporadas.fechaTermino}" /></td>

													<c:if test="${listaTemporadas.estado==true}">
														<td><c:out value="Temporada Activa"></c:out></td>
													</c:if>

													<c:if test="${listaTemporadas.estado!=true}">
														<td><c:out value="Temporada Inactiva"></c:out></td>
													</c:if>

													<c:if test="${listaTemporadas.estado==true}">

														<td><a href="#"
															onclick="editarTemporada(${listaTemporadas.idTemporada});"><i
																title="Editar Temporada" class="fa fa-edit fa-lg"
																style="color: #1CE4D0"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a
															href="#" title="Eliminar Temporada"
															onclick="eliminarTemporada(${listaTemporadas.idTemporada});"><i
																class="fa fa-trash-o fa-lg" style="color: red"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
															<a href="#" title="Finalizar Temporada"
															onclick="finalizarTemporada(${listaTemporadas.idTemporada});"><i
																class="fa fa-check fa-lg" style="color: green"></i></a></td>

													</c:if>

													<c:if test="${listaTemporadas.estado!=true}">

														<td></td>

													</c:if>

												</tr>
											</c:forEach>
										</tbody>

									</table>
								</div>
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


			<div class="modal fade" id="modalAgregarTemporada" tabindex="-1"
				role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">

							<h4 class="modal-title" id="myModalLabel">Agregar Temporada</h4>
						</div>
						<div class="modal-body">


							<div class="row">

								<div class="box-body">

									<div id="form-editar" class="form-group">

										<label class="col-sm-4 control-label">Nombre</label>
										<div class="col-sm-6">
											<input type="text" class="form-control" id="nombreTemporada">
											<span id="errorNombreTemporada" class="error"
												style="display: none">Ingrese el nombre de la
												temporada</span>
										</div>
										<br> <br> <label class="col-sm-4 control-label">Fecha
											de inicio</label>
										<div class="col-sm-6">
											<input type="date" class="form-control" id="fechaInicio">
											<span id="errorFechaInicio" class="error"
												style="display: none">Indique la fecha de inicio</span>
										</div>

										<br> <br> <label class="col-sm-4 control-label">Fecha
											de término</label>

										<div class="col-sm-6">
											<input type="date" class="form-control" id="fechaTermino">
											<span id="errorFechaTermino" class="error"
												style="display: none">Indique la fecha de término</span> <span
												id="errorFechaTerminoMenor" class="error"
												style="display: none">La fecha de término debe ser
												mayor a fecha de inicio</span>
										</div>

									</div>


								</div>


							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-danger pull-left"
									data-dismiss="modal">Cerrar</button>
								<button id="botonGuardar" type="button" class="btn btn-primary"
									onclick="guardarDatosTemporada();">Agregar</button>
							</div>
						</div>
					</div>
				</div>
			</div>


			<!-- Modal editar -->


			<div class="modal fade" id="modalEditarTemporada" tabindex="-1"
				role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">

							<h4 class="modal-title" id="myModalLabel">Editar Temporada</h4>
						</div>
						<div class="modal-body">


							<div class="row">

								<div class="box-body">

									<div id="form-editar" class="form-group">

										<div style="display: none">
											<input id="idTemporadaEditar" />
										</div>

										<label class="col-sm-4 control-label">Nombre</label>
										<div class="col-sm-6">
											<input type="text" class="form-control"
												id="nombreTemporadaEditar"> <span
												id="errorNombreTemporadaEditar" class="error"
												style="display: none">Ingrese el nombre de la
												temporada</span>
										</div>
										<br> <br> <label class="col-sm-4 control-label">Fecha
											de inicio</label>
										<div class="col-sm-6">
											<input type="date" class="form-control"
												id="fechaInicioEditar"> <span
												id="errorFechaInicioEditar" class="error"
												style="display: none">Indique la fecha de inicio</span>
										</div>

										<br> <br> <label class="col-sm-4 control-label">Fecha
											de término</label>
										<div class="col-sm-6">
											<input type="date" class="form-control"
												id="fechaTerminoEditar"> <span
												id="errorFechaTerminoEditar" class="error"
												style="display: none">Indique la fecha de término</span> <span
												id="errorFechaTerminoMenorEditar" class="error"
												style="display: none">La fecha de término debe ser
												mayor a fecha de inicio</span>
										</div>
									</div>


								</div>


							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-danger pull-left"
									data-dismiss="modal">Cerrar</button>
								<button id="botonGuardar" type="button" class="btn btn-primary"
									onclick="guardarDatosTemporadaEditar();">Actualizar</button>
							</div>
						</div>
					</div>
				</div>
			</div>

			</section>

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
	function agregarTemporada() {
		$('#modalAgregarTemporada').modal('show');

		//Limpiar modal
		$('#nombreTemporada').val("");
		$('#fechaInicio').val("");
		$("#fechaTermino").val("");
		

		document.getElementById('errorNombreTemporada').style.display = 'none';
		document.getElementById('nombreTemporada').style.border = "";

		document.getElementById('errorFechaInicio').style.display = 'none';
		document.getElementById('fechaInicio').style.border = "";

		document.getElementById('errorFechaTermino').style.display = 'none';
		document.getElementById('fechaTermino').style.border = "";
		
		document.getElementById('errorFechaTerminoMenor').style.display = 'none';
		document.getElementById('fechaTermino').style.border = "";
		
		//Verificar la cantidad maxima de temporadas activas
		//Pueden ser solo 4
	}

	function guardarDatosTemporada() {
		//Obtener los datos
		var nombreTemporada = $('#nombreTemporada').val();
		var fechaInicio = $('#fechaInicio').val();
		var fechaTermino= $('#fechaTermino').val();

		console.log(nombreTemporada);
		console.log(fechaInicio);
		console.log(fechaTermino);

		//Validacion para el nombre
		if (nombreTemporada == "") {
			document.getElementById('errorNombreTemporada').style.display = 'inline';
			document.getElementById('nombreTemporada').style.border = "1px solid red";
		} else {
			document.getElementById('errorNombreTemporada').style.display = 'none';
			document.getElementById('nombreTemporada').style.border = "";
		}

		//Validacion para el tipo
		if (fechaInicio == "") {
			document.getElementById('errorFechaInicio').style.display = 'inline';
			document.getElementById('fechaInicio').style.border = "1px solid red";
		} else {
			document.getElementById('errorFechaInicio').style.display = 'none';
			document.getElementById('fechaInicio').style.border = "";
		}

		//Validacion para la unidad de medida
		if (fechaTermino=="") {
			document.getElementById('errorFechaTermino').style.display = 'inline';
			document.getElementById('fechaTermino').style.border = "1px solid red";
		} else {
			document.getElementById('errorFechaTermino').style.display = 'none';
			document.getElementById('fechaTermino').style.border = "";
		}

		if (nombreTemporada != "" && fechaInicio != ""
				&& fechaTermino != "") {
			
			//Validar que la fecha de inicio sea menor a la fecha de termino
			if(fechaTermino<fechaInicio){
				document.getElementById('errorFechaTerminoMenor').style.display = 'inline';
				document.getElementById('fechaTermino').style.border = "1px solid red";
			}else{
				$.ajax({
					type : 'POST',
					url : "agregarTemporada",
					dataType : 'json',
					data : {
						nombreTemporada: nombreTemporada,
						fechaInicio: fechaInicio,
						fechaTermino: fechaTermino
					},
					success : function(data) {
						if(data.idTemporada>0){
							$('#modalAgregarTemporada').modal('hide');

							var tabla = $('#listaTemporadas').dataTable();
							var num = tabla.fnSettings().fnRecordsTotal();
							
							//Formatear fechas
							var fechaInicio = moment(data.fechaInicio,'YYYY/MM/DD');
							fechaInicio = fechaInicio.format('DD-MM-YYYY');
							
							var fechaTermino = moment(data.fechaTermino,'YYYY/MM/DD');
							fechaTermino = fechaTermino.format('DD-MM-YYYY');
							
							var estado;
							if(data.estado==true){
								estado="Temporada Activa";
							}else{
								estado="Temporada Inactiva";
							}

							$('#listaTemporadas').dataTable().fnAddData(

									[ num + 1, data.nombre, fechaInicio,
											fechaTermino, estado , '<a href="#" title="Editar Temporada" onclick="editarTemporada('+data.idTemporada+');"><i class="fa fa-edit fa-lg" style="color: #1CE4D0"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" title="Eliminar Temporada" onclick="eliminarTemporada('+data.idTemporada+');"><i class="fa fa-trash-o fa-lg" style="color: red"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" title="Finalizar Temporada" onclick="finalizarTemporada('+data.idTemporada+');"><i class="fa fa-edit fa-lg" style="color: #1CE4D0"></i></a>' ]

							);

							$("#listaTemporadas").DataTable().page('last')
									.draw('page');

							toastr.success("Temporada agregada correctamente");
						}

					},
					error : function(jqXHR, errorThrown) {
						toastr.error("Error al agregar la temporada");
					}
				});
			}
			
			
		}

	}

	function editarTemporada(idTemporada) {
		console.log(idTemporada);
		
		if(idTemporada>0){
			//Obtener los datos del insumo
			 $.ajax({
					type : 'POST',
					url : "obtenerTemporadaAEditar",
					dataType : 'json',
					data:{
						idTemporada:idTemporada
					},
					success : function(data) {
						console.log(data);
						if(!$.isEmptyObject(data)){
							//Cargar los datos en el modal
							$('#nombreTemporadaEditar').val(data.nombre);
							$('#fechaInicioEditar').val(data.fechaInicio);
							$('#fechaTerminoEditar').val(data.fechaTermino);
							
							$('#idTemporadaEditar').val(data.idTemporada);
						
							$('#modalEditarTemporada').modal('show');
							
						}

					},
					error : function(jqXHR, errorThrown) {
						toastr.error("Error al obtener los datos de la temporada");
					}
				});
		}
			
	}
	
	function eliminarTemporada(idTemporada){
		console.log(idTemporada);
		
		if(idTemporada>0){
			swal({
				  title: "¿Está seguro de eliminar la temporada?",
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
						url : "eliminarTemporada",
						dataType : 'json',
						data : {
							idTemporada:idTemporada
						},
						success : function(data) {
							if(data==true){
								swal.close();
								toastr.success("Temporada eliminada correctamente");

								//Actualizar el data table
								 $.ajax({
										type : 'POST',
										url : "obtenerListaTemporadas",
										dataType : 'json',
										success : function(data) {
											
											if(!$.isEmptyObject(data)){
												//vaciar datatable
												var oTable = $('#listaTemporadas').dataTable();
												oTable.fnClearTable();
												
												//Llenar data table
												for(var i=0;i<data.length;i++){
													
													//Formatear fechas
													var fechaInicio = moment(data[i].fechaInicio,'YYYY/MM/DD');
													fechaInicio = fechaInicio.format('DD-MM-YYYY');
													
													var fechaTermino = moment(data[i].fechaTermino,'YYYY/MM/DD');
													fechaTermino = fechaTermino.format('DD-MM-YYYY');
													
													var estado;
													if(data[i].estado==true){
														estado="Temporada Activa";
													}else{
														estado="Temporada Inactiva";
													}
													
													if(data[i].estado==true){
														$('#listaTemporadas').dataTable().fnAddData(

																[i + 1, data[i].nombre, fechaInicio,
																		fechaTermino, estado, '<a href="#" title="Editar Temporada" onclick="editarTemporada('+data[i].idTemporada+');"><i class="fa fa-edit fa-lg" style="color: #1CE4D0"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" title="Eliminar Temporada" onclick="eliminarTemporada('+data[i].idTemporada+');"><i class="fa fa-trash-o fa-lg" style="color: red"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" title="Finalizar Temporada" onclick="finalizarTemporada('+data[i].idTemporada+');"><i class="fa fa-edit fa-lg" style="color: #1CE4D0"></i></a>' ]

														);
													}else{
														$('#listaTemporadas').dataTable().fnAddData(

																[i + 1, data[i].nombre, fechaInicio,
																		fechaTermino, estado, '' ]

														);
													}
													
													
												}
											}
											
											
											

										},
										error : function(jqXHR, errorThrown) {
											toastr.error("Error al obtener las temporadas");
										}
									});
							}else{
								toastr.error("Error al obtener los insumos");
							}

						},
						error : function(jqXHR, errorThrown) {
							toastr.error("Error al eliminar el insumo");
						}
					});
				  
				});
		}
		
	}
	
	function guardarDatosTemporadaEditar(){
		//Obtener los datos
		
		var idTemporada = $('#idTemporadaEditar').val();
		var nombreTemporada = $('#nombreTemporadaEditar').val();
		var fechaInicio = $('#fechaInicioEditar').val();
		var fechaTermino= $('#fechaTerminoEditar').val();

		console.log(nombreTemporada);
		console.log(fechaInicio);
		console.log(fechaTermino);

		//Validacion para el nombre
		if (nombreTemporada == "") {
			document.getElementById('errorNombreTemporadaEditar').style.display = 'inline';
			document.getElementById('nombreTemporadaEditar').style.border = "1px solid red";
		} else {
			document.getElementById('errorNombreTemporadaEditar').style.display = 'none';
			document.getElementById('nombreTemporadaEditar').style.border = "";
		}

		//Validacion para el tipo
		if (fechaInicio == "") {
			document.getElementById('errorFechaInicioEditar').style.display = 'inline';
			document.getElementById('fechaInicioEditar').style.border = "1px solid red";
		} else {
			document.getElementById('errorFechaInicioEditar').style.display = 'none';
			document.getElementById('fechaInicioEditar').style.border = "";
		}

		//Validacion para la unidad de medida
		if (fechaTermino=="") {
			document.getElementById('errorFechaTerminoEditar').style.display = 'inline';
			document.getElementById('fechaTerminoEditar').style.border = "1px solid red";
		} else {
			document.getElementById('errorFechaTerminoEditar').style.display = 'none';
			document.getElementById('fechaTerminoEditar').style.border = "";
		}


		if (nombreTemporada != "" && fechaInicio != ""
			&& fechaTermino != "" && idTemporada>0) {
		
		//Validar que la fecha de inicio sea menor a la fecha de termino
		if(fechaTermino<fechaInicio){
			document.getElementById('errorFechaTerminoMenorEditar').style.display = 'inline';
			document.getElementById('fechaTerminoEditar').style.border = "1px solid red";
		}else{
			$.ajax({
				type : 'POST',
				url : "editarTemporada",
				dataType : 'json',
				data : {
					idTemporada: idTemporada,
					nombreTemporada: nombreTemporada,
					fechaInicio: fechaInicio,
					fechaTermino: fechaTermino
				},
				success : function(data) {
					if(data==true){
						
						//Actualizar el data table
						 $.ajax({
								type : 'POST',
								url : "obtenerListaTemporadas",
								dataType : 'json',
								success : function(data) {
									
									if(!$.isEmptyObject(data)){
										//vaciar datatable
										var oTable = $('#listaTemporadas').dataTable();
										oTable.fnClearTable();
										
										//Llenar data table
										for(var i=0;i<data.length;i++){
											
											//Formatear fechas
											var fechaInicio = moment(data[i].fechaInicio,'YYYY/MM/DD');
											fechaInicio = fechaInicio.format('DD-MM-YYYY');
											
											var fechaTermino = moment(data[i].fechaTermino,'YYYY/MM/DD');
											fechaTermino = fechaTermino.format('DD-MM-YYYY');
											
											var estado;
											if(data[i].estado==true){
												estado="Temporada Activa";
											}else{
												estado="Temporada Inactiva";
											}
											
											if(data[i].estado==true){
												$('#listaTemporadas').dataTable().fnAddData(

														[i + 1, data[i].nombre, fechaInicio,
																fechaTermino, estado, '<a href="#" title="Editar Temporada" onclick="editarTemporada('+data[i].idTemporada+');"><i class="fa fa-edit fa-lg" style="color: #1CE4D0"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" title="Eliminar Temporada" onclick="eliminarTemporada('+data[i].idTemporada+');"><i class="fa fa-trash-o fa-lg" style="color: red"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" title="Finalizar Temporada" onclick="finalizarTemporada('+data[i].idTemporada+');"><i class="fa fa-edit fa-lg" style="color: #1CE4D0"></i></a>' ]

												);
											}else{
												$('#listaTemporadas').dataTable().fnAddData(

														[i + 1, data[i].nombre, fechaInicio,
																fechaTermino, estado, '' ]

												);
											}
											
											
										}
									}
									
									//Close modal
									$('#modalEditarTemporada').modal('hide');
									

								},
								error : function(jqXHR, errorThrown) {
									toastr.error("Error al obtener las temporadas");
								}
							});
						
							toastr.success("Temporada editada correctamente");
						
						
						
						
					}

				},
				error : function(jqXHR, errorThrown) {
					toastr.error("Error al agregar la temporada");
				}
			});
		}
		
		
	}

	}
	
	
	function finalizarTemporada(idTemporada){
		if(idTemporada>0){
			$.ajax({
				type : 'POST',
				url : "finalizarTemporada",
				dataType : 'json',
				data:{
					idTemporada: idTemporada
				},
				success : function(data) {
					console.log(data);
					if(data==true){
						//Actualizar el data table
						 $.ajax({
								type : 'POST',
								url : "obtenerListaTemporadas",
								dataType : 'json',
								success : function(data) {
									
									if(!$.isEmptyObject(data)){
										//vaciar datatable
										var oTable = $('#listaTemporadas').dataTable();
										oTable.fnClearTable();
										
										//Llenar data table
										for(var i=0;i<data.length;i++){
											
											//Formatear fechas
											var fechaInicio = moment(data[i].fechaInicio,'YYYY/MM/DD');
											fechaInicio = fechaInicio.format('DD-MM-YYYY');
											
											var fechaTermino = moment(data[i].fechaTermino,'YYYY/MM/DD');
											fechaTermino = fechaTermino.format('DD-MM-YYYY');
											
											var estado;
											if(data[i].estado==true){
												estado="Temporada Activa";
											}else{
												estado="Temporada Inactiva";
											}
											
											if(data[i].estado==true){
												$('#listaTemporadas').dataTable().fnAddData(

														[i + 1, data[i].nombre, fechaInicio,
																fechaTermino, estado, '<a href="#" title="Editar Temporada" onclick="editarTemporada('+data[i].idTemporada+');"><i class="fa fa-edit fa-lg" style="color: #1CE4D0"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" title="Eliminar Temporada" onclick="eliminarTemporada('+data[i].idTemporada+');"><i class="fa fa-trash-o fa-lg" style="color: red"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" title="Finalizar Temporada" onclick="finalizarTemporada('+data[i].idTemporada+');"><i class="fa fa-edit fa-lg" style="color: #1CE4D0"></i></a>' ]

												);
											}else{
												$('#listaTemporadas').dataTable().fnAddData(

														[i + 1, data[i].nombre, fechaInicio,
																fechaTermino, estado, '' ]

												);
											}
											
											
										}
									}
									
									
									

								},
								error : function(jqXHR, errorThrown) {
									toastr.error("Error al obtener las temporadas");
								}
							});
						
						toastr.success("La temporada seleccionada ha finalizado");
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
	$('#listaTemporadas').DataTable({
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
			"sInfoEmpty" : "",
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