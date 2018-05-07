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
							<h3 class="box-title">Lista de Predios</h3>
							<button id="agregarPredio" type="button"
								class="btn btn-primary pull-right" onclick="agregarPredio();">
								<i class="fa fa-plus-circle"> Agregar Predio</i>
							</button>

						</div>
						<!-- /.box-header -->
						<div class="box-body">
							<div class="row">

								<div class="col-sm-12">
									<table id="listaPredios"
										class="table table-striped table-bordered table-hover">

										<thead>
											<tr>
												<th>N�</th>
												<th>Nombre</th>
												<th>Superficie</th>
												<th>Sector</th>
												<th>Acci�n</th>

											</tr>
										</thead>

										<tbody>

											<c:forEach var="predios" items="${listaPredios }"
												varStatus="loop">
												<tr>
													<c:set var="index" value="${loop.index}" />
													<c:set var="index" value="${index + 1}" />

													<td><c:out value="${index}"></c:out></td>
													<td><c:out value="${predios.nombre}"></c:out></td>
													<td><c:out value="${predios.superficie}"></c:out></td>
													<td><c:out value="${predios.sector.nombre}"></c:out></td>
													<td><a href="#"
														onclick="editarPredio(${predios.idPredio});"><i
															class="fa fa-edit fa-lg" style="color: #1CE4D0"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a
														href="#" onclick="eliminarPredio(${predios.idPredio});"><i
															class="fa fa-trash-o fa-lg" style="color: red"></i></a></td>

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


			<div class="modal fade" id="modalAgregarPredio" tabindex="-1"
				role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">

							<h4 class="modal-title" id="myModalLabel">Agregar Predio</h4>
						</div>
						<div class="modal-body">


							<div class="row">

								<div class="box-body">

									<div id="form-editar" class="form-group">

										<label class="col-sm-4 control-label">Nombre</label>
										<div class="col-sm-6">
											<input type="text" class="form-control" id="nombrePredio">
											<span id="errorNombre" class="error" style="display: none">Ingrese
												el nombre del predio</span>
										</div>

										<br> <br> <label class="col-sm-4 control-label">Sector
										</label>
										<div class="col-sm-6">
											<select class="form-control" id="sectorSeleccionado"
												onchange="superficieTotalPredios()">
												<option value="-1">Seleccione sector al que
													pertenece</option>
												<c:forEach items="${sectores}" var="sectores">
													<option value="${sectores.idSector}"><c:out
															value="${sectores.nombre}" /></option>

												</c:forEach>

											</select> <span id="errorSector" class="error" style="display: none">Seleccione
												el sector</span>

										</div>
										<div id="mostrar" style="display: none">
											<br> <br> <label class="col-sm-4 control-label">Superficie
												total sector</label>
											<div class="col-sm-6">
												<input type="number" class="form-control" id="idinput1"
													disabled>

											</div>

											<br> <br> <label class="col-sm-4 control-label">Superficie
												ocupada</label>
											<div class="col-sm-6">
												<input type="number" class="form-control" id="idinput2"
													disabled>


											</div>

											<br> <br> <label class="col-sm-4 control-label">Superficie
												disponible</label>
											<div class="col-sm-6">
												<input type="number" class="form-control" id="idinput3"
													disabled>


											</div>

											<br> <br> <label class="col-sm-4 control-label">Superficie
												(m<sup>2</sup>) predio
											</label>
											<div class="col-sm-6">
												<input type="number" class="form-control"
													id="superficiePredio"> <span id="errorSuperficie"
													class="error" style="display: none">Ingrese la
													superficie del predio</span> <span id="errorSubTotal"
													class="error" style="display: none">La superficie
													ingresada debe ser menor</span> <span id="errorSuperficieNegativa"
													class="error" style="display: none">La superficie no
													puede ser negativa</span>
											</div>
										</div>

									</div>


								</div>


							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-danger pull-left"
									data-dismiss="modal">Cerrar</button>
								<button id="botonGuardar" type="button" class="btn btn-primary"
									onclick="guardarDatosPredio();">Agregar</button>
							</div>
						</div>
					</div>
				</div>
			</div>


			<!-- Modal editar -->


			<div class="modal fade" id="modalEditarPredio" tabindex="-1"
				role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">

							<h4 class="modal-title" id="myModalLabel">Editar Predio</h4>
						</div>
						<div class="modal-body">


							<div class="row">

								<div class="box-body">

									<div id="form-editar" class="form-group">

										<div style="display: none">
											<input id="idPredioEditar" />
										</div>

										<label class="col-sm-4 control-label">Nombre</label>
										<div class="col-sm-6">
											<input type="text" class="form-control"
												id="nombrePredioEditar"> <span
												id="errorNombreEditar" class="error" style="display: none">Ingrese
												el nombre del predio</span>
										</div>
										<br> <br> <label class="col-sm-4 control-label">Sector</label>
										<div class="col-sm-6">
											<select class="form-control" id="sectorEditar"
												onchange="superficieTotalPrediosEditar()">
											</select> <span id="errorSectorEditar" class="error"
												style="display: none">Seleccione el sector</span>
										</div>


										<br> <br> <label class="col-sm-4 control-label">Superficie
											total sector</label>
										<div class="col-sm-6">
											<input type="number" class="form-control" id="totalSector"
												disabled>

										</div>

										<br> <br> <label class="col-sm-4 control-label">Superficie
											ocupada</label>
										<div class="col-sm-6">
											<input type="number" class="form-control" id="totalPredios"
												disabled>

										</div>

										<br> <br> <label class="col-sm-4 control-label">Superficie
											disponible</label>
										<div class="col-sm-6">
											<input type="number" class="form-control"
												id="superficieDisponible" disabled>

										</div>

										<br> <br> <label class="col-sm-4 control-label">Superficie
										</label>
										<div class="col-sm-6">
											<input type="number" class="form-control"
												id="superficieEditar"> <span
												id="errorSuperficieEditar" class="error"
												style="display: none">Ingrese superficie</span> <span
												id="errorSubTotal" class="error" style="display: none">La
												superficie ingresada debe ser menor</span> <span
												id="errorSupNegativa" class="error" style="display: none">La
												superficie no puede ser negativa</span>
										</div>
									</div>


								</div>

							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-danger pull-left"
									data-dismiss="modal">Cerrar</button>
								<button id="botonGuardar" type="button" class="btn btn-primary"
									onclick="guardarDatosPredioEditar();">Actualizar</button>
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
	function agregarPredio() {
		$('#modalAgregarPredio').modal('show');

		//Limpiar modal
		$('#nombrePredio').val("");
		$('#sectorSeleccionado').val(-1);
		$('#idinput1').val("");
		$('#idinput2').val("");
		$('#idinput3').val("");
		$("#superficiePredio").val("");

		document.getElementById('errorNombre').style.display = 'none';
		document.getElementById('nombrePredio').style.border = "";

		document.getElementById('errorSector').style.display = 'none';
		document.getElementById('sectorSeleccionado').style.border = "";

		document.getElementById('errorSuperficieNegativa').style.display = 'none';
		document.getElementById('superficiePredio').style.border = "";
		
		document.getElementById('errorSuperficie').style.display = 'none';
		document.getElementById('superficiePredio').style.border = "";
		
		document.getElementById('errorSubTotal').style.display = 'none';
		document.getElementById('superficiePredio').style.border = "";
		
		document.getElementById('mostrar').style.display = 'none';
	}
	
	

	function superficieTotalPredios() {
		var idSector = $("#sectorSeleccionado").val();
		console.log(idSector);

		if (idSector >0) {
			//habilitar el input de superficie
			document.getElementById('mostrar').style.display = 'inline';
			
			//obtengo el total de la superficie del sector

			$.ajax({
				type : 'POST',
				url : "obtenerTotalSuperficeSector",
				dataType : 'json',
				data : {
					idSector : idSector
				},
				success : function(data) {
					$("#idinput1").val(data);
					console.log(data);

				}

			}),
			$.ajax({
				type : 'POST',
				url : "obtenerTotalSuperficePrediosSector",
				dataType : 'json',
				data : {
					idSector : idSector
				},
				success : function(data) {
					$("#idinput2").val(data);
					console.log(data);
					
					
				}
				

			})
			
			
		}
		
		//superficie disponile
		var input1=$("#idinput1").val();
		var input2=$("#idinput2").val();
		var primerInput = parseInt(input1);
		var segundoInput = parseInt(input2);
		
		$("#idinput3").val(primerInput-segundoInput);
		
		//desactiva el input de superficie cuando superficie disponible =0
		 var sup = document.getElementById('superficiePredio');
		if($("#idinput3").val()==0){
			sup.disabled = true;
		}else{
			sup.disabled = false;
		}
		

	}
	
	
	function superficieTotalPrediosEditar() {
		var idSector = $("#sectorEditar").val();
		console.log(idSector);

		if (idSector >0) {
			//Obtengo el total de la superficie de los predios de un sector
			$.ajax({
				type : 'POST',
				url : "obtenerTotalSuperficePrediosSector",
				dataType : 'json',
				data : {
					idSector : idSector
				},
				success : function(data) {
					$("#totalPredios").val(data);
					console.log(data);
				}

			}),
			//obtengo el total de la superficie del sector

			$.ajax({
				type : 'POST',
				url : "obtenerTotalSuperficeSector",
				dataType : 'json',
				data : {
					idSector : idSector
				},
				success : function(data) {
					$("#totalSector").val(data);
					console.log(data);

				}

			})
		}
		
		//superficie disponible 
		var totalSector=$("#totalSector").val();
		var  totalPredios=$("#totalPredios").val();
		$("#superficieDisponible").val(totalSector-totalPredios);
		
		//desactiva el input de superficie cuando superficie disponible =0
		 var Superficie = document.getElementById('superficieEditar');
		if($("#superficieDisponible").val()==0){
			Superficie.disabled = true;
		}else{
			Superficie.disabled = false;
		}

	}
	
	

	function guardarDatosPredio() {
		
		//Obtener los datos
		var nombrePredio = $('#nombrePredio').val();

		var idSector = $("#sectorSeleccionado").val();

		var superficie = $('#superficiePredio').val();
		
		
		//para obtener la superficie disponible
		var input1=$("#idinput1").val();
		var input2=$("#idinput2").val();
		var totalSuperficieSector =parseInt(input1);
		var totalSuperficiePredios = parseInt(input2);
		

		console.log(nombrePredio);
		console.log(idSector);
		console.log(superficie);

		//Validacion para el nombre del predio
		if (nombrePredio == "") {
			document.getElementById('errorNombre').style.display = 'inline';
			document.getElementById('nombrePredio').style.border = "1px solid red";
		} else {
			document.getElementById('errorNombre').style.display = 'none';
			document.getElementById('nombrePredio').style.border = "";
		}

		//Validacion para el sector donde se ubica el predio
		if (idSector ==-1) {
			document.getElementById('errorSector').style.display = 'inline';
			document.getElementById('sectorSeleccionado').style.border = "1px solid red";
		} else {
			document.getElementById('errorSector').style.display = 'none';
			document.getElementById('sectorSeleccionado').style.border = "";
		}

		//Validacion para la superficie del predio a agregar
		if (superficie =="") {
			document.getElementById('errorSuperficie').style.display = 'inline';
			document.getElementById('superficiePredio').style.border = "1px solid red";
		} else {
			
			if (superficie<0 && superficie !="") {
				document.getElementById('errorSuperficie').style.display = 'none';
				document.getElementById('errorSuperficieNegativa').style.display = 'inline';
				document.getElementById('superficiePredio').style.border = "1px solid red";
			} else {
				document.getElementById('errorSuperficieNegativa').style.display = 'none';
				document.getElementById('superficiePredio').style.border = "";
			}
			
		}
		
		if(superficie!="" && superficie>0){
			document.getElementById('errorSuperficie').style.display = 'none';
			document.getElementById('superficiePredio').style.border = "";
		}
		
		
		if(superficie>(($('#idinput1').val())-($('#idinput2').val()))){
			document.getElementById('errorSubTotal').style.display = 'inline';
			document.getElementById('superficiePredio').style.border = "1px solid red";
		}else {
			document.getElementById('errorSubTotal').style.display = 'none';
			document.getElementById('superficiePredio').style.border = "";
		}
		
		
		
		
		 if (nombrePredio != "" && superficie>0 && superficie<=(totalSuperficieSector-totalSuperficiePredios) ) {
			$
					.ajax({
						type : 'POST',
						url : "agregarPredio",
						dataType : 'json',
						data : {
							nombre : nombrePredio,
							superficie : superficie,
						     idSector : idSector,
							
						},
						success : function(data) {
							console.log(data);

							if (data.idPredio > 0) {
								$('#modalAgregarPredio').modal('hide');

								var tabla = $('#listaPredios').dataTable();
								var num = tabla.fnSettings().fnRecordsTotal();

								$('#listaPredios')
										.dataTable()
										.fnAddData(

												[
														num + 1,
														data.nombre,
														data.superficie,
														data.sector.nombre,
														'<a href="#" onclick="editarPredio('
																+ data.idPredio
																+ ');"><i class="fa fa-edit fa-lg" style="color: #1CE4D0"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" onclick="eliminarPredio('
																+ data.idPredio
																+ ');"><i class="fa fa-trash-o fa-lg" style="color: red"></i></a>' ]

										);

								$("#listaPredios").DataTable().page('last')
										.draw('page');

								toastr.success("Predio agregado correctamente");
							} else {
								toastr.error("Error al agregar el predio");
							}

						},
						error : function(jqXHR, errorThrown) {
							toastr.error("Error al agregar el predio");
						}
					});
		}

	}

	function editarPredio(idPredio) {
		console.log(idPredio);
		var TotalSector=$("#idinput1").val();
		var TotalPredios=$("#idinput2").val();

		if (idPredio > 0) {
			//Obtener los datos del predio a editar
			$.ajax({
				type : 'POST',
				url : "obtenerPredioAEditar",
				dataType : 'json',
				data : {
					idPredio : idPredio
				},
				success : function(data) {
					console.log(data);
					if (!$.isEmptyObject(data)) {
						//Cargar los datos en el modal
						$('#nombrePredioEditar').val(data.nombre);
						$('#superficieEditar').val(data.superficie);
			
						$('#totalSector').val(TotalSector);
						$('#totalPredios').val(TotalPredios);
						
						
						$('#sectorEditar').empty();
						
						//obtengo los option de los sectores
						var idSector = $('#sectorSeleccionado option');

						for (var i = 0; i < idSector.length; i++) {
							if (idSector[i].innerText == data.sector.nombre) {
								$("#sectorEditar").append(
										'<option value='+idSector[i].value+' selected>'
												+ idSector[i].innerText
												+ '</option>');
							} else {
								$("#sectorEditar").append(
										'<option value='+idSector[i].value+'>'
												+ idSector[i].innerText
												+ '</option>');
							}

						}


						//Cargar el id del predio en el input oculto
						$('#idPredioEditar').val(idPredio);

						$('#modalEditarPredio').modal('show');

					}

				},
				error : function(jqXHR, errorThrown) {
					toastr.error("Error al editar el predio");
				}
			});
		}

	}

	function eliminarPredio(idPredio) {
		console.log(idPredio);

		if (idPredio > 0) {
			swal(
					{
						title : "�Est� seguro de eliminar el predio?",
						text : "Esta acci�n no podr� ser recuperada",
						type : "warning",
						showCancelButton : true,
						confirmButtonClass : "btn-danger",
						cancelButtonText : "Cancelar",
						confirmButtonText : "Si, Eliminar",
						closeOnConfirm : false
					},
					function() {

						//Ajax para eliminar
						$
								.ajax({
									type : 'POST',
									url : "eliminarPredio",
									dataType : 'json',
									data : {
										idPredio : idPredio
									},
									success : function(data) {
										if (data == true) {
											swal.close();
											toastr
													.success("Predio eliminado correctamente");

											//Actualizar el data table
											$
													.ajax({
														type : 'POST',
														url : "obtenerListaPredios",
														dataType : 'json',
														success : function(data) {

															if (!$
																	.isEmptyObject(data)) {
																//vaciar datatable
																var oTable = $(
																		'#listaPredios')
																		.dataTable();
																oTable
																		.fnClearTable();

																//Llenar data table
																for (var i = 0; i < data.length; i++) {
																	$(
																			'#listaPredios')
																			.dataTable()
																			.fnAddData(

																					[
																							i + 1,
																							data[i].nombre,
																							data[i].superficie,
																							data[i].sector.nombre,
																							'<a href="#" onclick="editarPredio('
																									+ data[i].idPredio
																									+ ');"><i class="fa fa-edit fa-lg" style="color: #1CE4D0"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" onclick="eliminarPredio('
																									+ data[i].idPredio
																									+ ');"><i class="fa fa-trash-o fa-lg" style="color: red"></i></a>' ]

																			);
																}
															}

														},
														error : function(jqXHR,
																errorThrown) {
															toastr
																	.error("Error al obtener los predios");
														}
													});
										} else {
											toastr
													.error("Error al obtener los predios");
										}

									},
									error : function(jqXHR, errorThrown) {
										toastr
												.error("Error al eliminar el predio");
									}
								});

					});
		}

	}

	function guardarDatosPredioEditar() {
		//Obtener los datos
		var nombrePredioEditar = $('#nombrePredioEditar').val();

		var idSector = $("#sectorEditar").val();

		var superficieEditar = $('#superficieEditar').val();
		
		
		var totalSuperficieSector =$('#totalSector').val();
		var totalSuperficiePredios = $('#totalPredios').val();
		
		var idPredio=$('#idPredioEditar').val();

		console.log(nombrePredio);
		console.log(idSector);
		console.log(superficieEditar);

		//Validacion para el nombre del predio
		if (nombrePredioEditar == "") {
			document.getElementById('errorNombreEditar').style.display = 'inline';
			document.getElementById('nombrePredioEditar').style.border = "1px solid red";
		} else {
			document.getElementById('errorNombreEditar').style.display = 'none';
			document.getElementById('nombrePredioEditar').style.border = "";
		}

		//Validacion para el sector donde se ubica el predio
		if (idSector == -1) {
			document.getElementById('errorSectorEditar').style.display = 'inline';
			document.getElementById('sectorEditar').style.border = "1px solid red";
		} else {
			document.getElementById('errorSectorEditar').style.display = 'none';
			document.getElementById('sectorEditar').style.border = "";
		}

		//Validacion para la superficie del predio a agregar
		if (superficieEditar =="") {
			document.getElementById('errorSuperficieEditar').style.display = 'inline';
			document.getElementById('superficieEditar').style.border = "1px solid red";
		} else {
			
			if (superficieEditar<0 && superficieEditar !="" ) {
				document.getElementById('errorSuperficieEditar').style.display = 'none';
				document.getElementById('errorSupNegativa').style.display = 'inline';
				document.getElementById('superficieEditar').style.border = "1px solid red";
			} else {
				document.getElementById('errorSupNegativa').style.display = 'none';
				document.getElementById('superficieEditar').style.border = "";
			}
			
		} 
		
		if(superficieEditar!="" && superficieEditar>0){
			document.getElementById('errorSuperficie').style.display = 'none';
			document.getElementById('superficieEditar').style.border = "";
		}
		


		if (nombrePredioEditar != "" && superficieEditar>0 && idPredio>0) {
			$.ajax({
				type : 'POST',
				url : "editarPredio",
				dataType : 'json',
				data : {
					idPredio:idPredio,
					nombre : nombrePredioEditar,
					superficie : superficieEditar,
					idSector: idSector,
					
				},
				success : function(data) {
					console.log(data);

					if(data==true){
						
						//Actualizar el data table
						 $.ajax({
								type : 'POST',
								url : "obtenerListaPredios",
								dataType : 'json',
								success : function(data) {
									
									if(!$.isEmptyObject(data)){
										//vaciar datatable
										var oTable = $('#listaPredios').dataTable();
										oTable.fnClearTable();
										
										//Llenar data table
										for(var i=0;i<data.length;i++){
											$('#listaPredios').dataTable().fnAddData(

													[i + 1, data[i].nombre, data[i].superficie,
															data[i].sector.nombre, '<a href="#" onclick="editarPredio('+data[i].idPredio+');"><i class="fa fa-edit fa-lg" style="color: #1CE4D0"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" onclick="eliminarPredio('+data[i].idPredio+');"><i class="fa fa-trash-o fa-lg" style="color: red"></i></a>' ]

											);
										}
										toastr.success("Predio editado correctamente");
									}
									
									//Close modal
									$('#modalEditarPredio').modal('hide');
									

								},
								error : function(jqXHR, errorThrown) {
									toastr.error("Error al obtener predios");
								}
							});
						
						
						
					}else{
						toastr.error("Error al editar el predio");
					}

				},
				error : function(jqXHR, errorThrown) {
					toastr.error("Error al editar prediooooo");
				}
			});
		}
		
	
	}
</script>



<script>
	$('#listaPredios').DataTable({
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
			"sEmptyTable" : "Ning�n dato disponible en esta tabla",
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
				"sLast" : "�ltimo",
				"sNext" : "Siguiente",
				"sPrevious" : "Anterior"
			}
		}
	})
</script>

</html>