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
							<h3 class="box-title">Lista de Insumos</h3>
							<button id="agregarInsumo" type="button"
								class="btn btn-primary pull-right" onclick="agregarInsumo();">
								<i class="fa fa-plus-circle"> Agregar Insumo</i>
							</button>

						</div>
						<!-- /.box-header -->
						<div class="box-body">
							<div class="row">

								<div class="col-sm-12">
									<table id="listaInsumos"
										class="table table-striped table-bordered table-hover">

										<thead>
											<tr>
												<th>N°</th>
												<th>Nombre</th>
												<th>Tipo</th>
												<th>Unidad Medida</th>
												<th>Marca</th>
												<th></th>

											</tr>
										</thead>

										<tbody>

											<c:forEach var="listaInsumos" items="${listaInsumos }"
												varStatus="loop">
												<tr>
													<c:set var="index" value="${loop.index}" />
													<c:set var="index" value="${index + 1}" />

													<td><c:out value="${index}"></c:out></td>
													<td><c:out value="${listaInsumos.nombre}"></c:out></td>
													<td><c:out value="${listaInsumos.tipo}"></c:out></td>
													<td><c:out value="${listaInsumos.unidadMedida}"></c:out></td>
													<td><c:out value="${listaInsumos.marca}"></c:out></td>
													<td><a href="#"
														onclick="editarInsumo(${listaInsumos.idInsumo});"><i
															class="fa fa-edit fa-lg" style="color: #1CE4D0"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a
														href="#"
														onclick="eliminarInsumo(${listaInsumos.idInsumo});"><i
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


			<div class="modal fade" id="modalAgregarInsumo" tabindex="-1"
				role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">

							<h4 class="modal-title" id="myModalLabel">Agregar Insumo</h4>
						</div>
						<div class="modal-body">


							<div class="row">

								<div class="box-body">

									<div id="form-editar" class="form-group">

										<label class="col-sm-4 control-label">Nombre</label>
										<div class="col-sm-6">
											<input type="text" class="form-control" id="nombreInsumo">
											<span id="errorNombre" class="error" style="display: none">Ingrese
												el nombre del insumo</span>
										</div>
										<br> <br> <label class="col-sm-4 control-label">Tipo</label>
										<div class="col-sm-6">
											<select class="form-control" id="tipoInsumo">
												<option value="-1">Seleccione Tipo</option>
												<option value="1">Herramienta</option>
												<option value="2">Combustible</option>
												<option value="3">Semilla</option>
												<option value="4">Abono</option>
												<option value="5">Fertilizante</option>
												<option value="6">Herbicida</option>

											</select> <span id="errorTipo" class="error" style="display: none">Seleccione
												el tipo de insumo</span>
										</div>

										<br> <br> <label class="col-sm-4 control-label">Unidad
											de Medida</label>

										<div class="col-sm-6">
											<select class="form-control" id="umInsumo">
												<option value="-1">Seleccione Unidad de Medida</option>
												<option value="1">Kilogramo</option>
												<option value="2">Litro</option>
												<option value="3">Unidad</option>

											</select> <span id="errorUM" class="error" style="display: none">Seleccione
												la unidad de medida</span>
										</div>
										<br> <br> <label class="col-sm-4 control-label">Marca
											(Opcional)</label>

										<div class="col-sm-6">
											<input type="text" class="form-control" id="marcaInsumo">
										</div>
									</div>


								</div>


							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-danger pull-left"
									data-dismiss="modal">Cerrar</button>
								<button id="botonGuardar" type="button" class="btn btn-primary"
									onclick="guardarDatosInsumo();">Agregar</button>
							</div>
						</div>
					</div>
				</div>
			</div>


			<!-- Modal editar -->


			<div class="modal fade" id="modalEditarInsumo" tabindex="-1"
				role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">

							<h4 class="modal-title" id="myModalLabel">Editar Insumo</h4>
						</div>
						<div class="modal-body">


							<div class="row">

								<div class="box-body">

									<div id="form-editar" class="form-group">

										<div style="display: none">
											<input id="idInsumoEditar" />
										</div>

										<label class="col-sm-4 control-label">Nombre</label>
										<div class="col-sm-6">
											<input type="text" class="form-control"
												id="nombreInsumoEditar"> <span
												id="errorNombreEditar" class="error" style="display: none">Ingrese
												el nombre del insumo</span>
										</div>
										<br> <br> <label class="col-sm-4 control-label">Tipo</label>
										<div class="col-sm-6">
											<select class="form-control" id="tipoInsumoEditar">


											</select> <span id="errorTipoEditar" class="error"
												style="display: none">Seleccione el tipo de insumo</span>
										</div>

										<br> <br> <label class="col-sm-4 control-label">Unidad
											de Medida</label>

										<div class="col-sm-6">
											<select class="form-control" id="umInsumoEditar">

											</select> <span id="errorUMEditar" class="error" style="display: none">Seleccione
												la unidad de medida</span>
										</div>
										<br> <br> <label class="col-sm-4 control-label">Marca
											(Opcional)</label>

										<div class="col-sm-6">
											<input type="text" class="form-control"
												id="marcaInsumoEditar">
										</div>
									</div>


								</div>


							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-danger pull-left"
									data-dismiss="modal">Cerrar</button>
								<button id="botonGuardar" type="button" class="btn btn-primary"
									onclick="guardarDatosInsumoEditar();">Actualizar</button>
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
	function agregarInsumo() {
		$('#modalAgregarInsumo').modal('show');

		//Limpiar modal
		$('#nombreInsumo').val("");
		$('#marcaInsumo').val("");
		$("#tipoInsumo").val(-1);
		$("#umInsumo").val(-1);

		document.getElementById('errorUM').style.display = 'none';
		document.getElementById('umInsumo').style.border = "";

		document.getElementById('errorTipo').style.display = 'none';
		document.getElementById('tipoInsumo').style.border = "";

		document.getElementById('errorNombre').style.display = 'none';
		document.getElementById('nombreInsumo').style.border = "";
	}

	function guardarDatosInsumo() {
		//Obtener los datos
		var nombreInsumo = $('#nombreInsumo').val();

		var tipo = document.getElementById("tipoInsumo");
		var tipoSeleccionado = tipo.options[tipo.selectedIndex].text;

		var um = document.getElementById("umInsumo");
		var umSeleccionado = um.options[um.selectedIndex].text;

		var marca = $('#marcaInsumo').val();

		console.log(nombreInsumo);
		console.log(tipoSeleccionado);
		console.log(umSeleccionado);

		//Validacion para el nombre
		if (nombreInsumo == "") {
			document.getElementById('errorNombre').style.display = 'inline';
			document.getElementById('nombreInsumo').style.border = "1px solid red";
		} else {
			document.getElementById('errorNombre').style.display = 'none';
			document.getElementById('nombreInsumo').style.border = "";
		}

		//Validacion para el tipo
		if (tipoSeleccionado == "Seleccione Tipo") {
			document.getElementById('errorTipo').style.display = 'inline';
			document.getElementById('tipoInsumo').style.border = "1px solid red";
		} else {
			document.getElementById('errorTipo').style.display = 'none';
			document.getElementById('tipoInsumo').style.border = "";
		}

		//Validacion para la unidad de medida
		if (umSeleccionado == "Seleccione Unidad de Medida") {
			document.getElementById('errorUM').style.display = 'inline';
			document.getElementById('umInsumo').style.border = "1px solid red";
		} else {
			document.getElementById('errorUM').style.display = 'none';
			document.getElementById('umInsumo').style.border = "";
		}

		if (nombreInsumo != "" && tipoSeleccionado != "Seleccione Tipo"
				&& umSeleccionado != "Seleccione Unidad de Medida") {
			$.ajax({
				type : 'POST',
				url : "agregarInsumo",
				dataType : 'json',
				data : {
					nombre : nombreInsumo,
					tipo : tipoSeleccionado,
					um : umSeleccionado,
					marca : marca
				},
				success : function(data) {
					console.log(data);

					if (data.idInsumo > 0) {
						$('#modalAgregarInsumo').modal('hide');

						var tabla = $('#listaInsumos').dataTable();
						var num = tabla.fnSettings().fnRecordsTotal();

						$('#listaInsumos').dataTable().fnAddData(

								[ num + 1, data.nombre, data.tipo,
										data.unidadMedida, data.marca, '<a href="#" onclick="editarInsumo('+data.idInsumo+');"><i class="fa fa-edit fa-lg" style="color: #1CE4D0"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" onclick="eliminarInsumo('+data.idInsumo+');"><i class="fa fa-trash-o fa-lg" style="color: red"></i></a>' ]

						);

						$("#listaInsumos").DataTable().page('last')
								.draw('page');

						toastr.success("Insumo agregado correctamente");
					} else {
						toastr.error("Error al agregar el insumo");
					}

				},
				error : function(jqXHR, errorThrown) {
					toastr.error("Error al agregar el insumo");
				}
			});
		}

	}

	function editarInsumo(idInsumo) {
		console.log(idInsumo);
		
		if(idInsumo>0){
			//Obtener los datos del insumo
			 $.ajax({
					type : 'POST',
					url : "obtenerInsumoAEditar",
					dataType : 'json',
					data:{
						idInsumo:idInsumo
					},
					success : function(data) {
						console.log(data);
						if(!$.isEmptyObject(data)){
							//Cargar los datos en el modal
							$('#nombreInsumoEditar').val(data.nombre);
							$('#marcaInsumoEditar').val(data.marca);
							
							
							//obtengo los option de tipo insumo
							var tipoInsumo = $('#tipoInsumo option');
							
							for(var i=0;i<tipoInsumo.length;i++){
								if(tipoInsumo[i].innerText==data.tipo){
									$("#tipoInsumoEditar").append(
											'<option value='+tipoInsumo[i].value+' selected>'
													+ tipoInsumo[i].innerText
													+ '</option>');
								}else{
									$("#tipoInsumoEditar").append(
											'<option value='+tipoInsumo[i].value+'>'
													+ tipoInsumo[i].innerText
													+ '</option>');
								}
								
							}
							
							//obtengo los option de um insumo
							var umInsumo = $('#umInsumo option');
							
							for(var j=0;j<umInsumo.length;j++){
								if(umInsumo[j].innerText==data.unidadMedida){
									$("#umInsumoEditar").append(
											'<option value='+umInsumo[j].value+' selected>'
													+ umInsumo[j].innerText
													+ '</option>');
								}else{
									$("#umInsumoEditar").append(
											'<option value='+umInsumo[j].value+'>'
													+ umInsumo[j].innerText
													+ '</option>');
								}
								
							}
							
							//Cargar el id del insumo en el input oculto
							$('#idInsumoEditar').val(idInsumo);
	
							$('#modalEditarInsumo').modal('show');
							
						}

					},
					error : function(jqXHR, errorThrown) {
						toastr.error("Error al editar el insumo");
					}
				});
		}
			
	}
	
	function eliminarInsumo(idInsumo){
		console.log(idInsumo);
		
		if(idInsumo>0){
			swal({
				  title: "¿Está seguro de eliminar el insumo?",
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
						url : "eliminarInsumo",
						dataType : 'json',
						data : {
							idInsumo:idInsumo
						},
						success : function(data) {
							if(data==true){
								swal.close();
								toastr.success("Insumo eliminado correctamente");

								//Actualizar el data table
								 $.ajax({
										type : 'POST',
										url : "obtenerListaInsumos",
										dataType : 'json',
										success : function(data) {
											
											if(!$.isEmptyObject(data)){
												//vaciar datatable
												var oTable = $('#listaInsumos').dataTable();
												oTable.fnClearTable();
												
												//Llenar data table
												for(var i=0;i<data.length;i++){
													$('#listaInsumos').dataTable().fnAddData(

															[i + 1, data[i].nombre, data[i].tipo,
																	data[i].unidadMedida, data[i].marca, '<a href="#" onclick="editarInsumo('+data[i].idInsumo+');"><i class="fa fa-edit fa-lg" style="color: #1CE4D0"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" onclick="eliminarInsumo('+data[i].idInsumo+');"><i class="fa fa-trash-o fa-lg" style="color: red"></i></a>' ]

													);
												}
											}
											

										},
										error : function(jqXHR, errorThrown) {
											toastr.error("Error al obtener los insumos");
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
	
	function guardarDatosInsumoEditar(){
		//Obtener los datos
		var nombreInsumo = $('#nombreInsumoEditar').val();

		var tipo = document.getElementById("tipoInsumoEditar");
		var tipoSeleccionado = tipo.options[tipo.selectedIndex].text;

		var um = document.getElementById("umInsumoEditar");
		var umSeleccionado = um.options[um.selectedIndex].text;

		var marca = $('#marcaInsumoEditar').val();
		
		var idInsumo=$('#idInsumoEditar').val();

		console.log(nombreInsumo);
		console.log(tipoSeleccionado);
		console.log(umSeleccionado);

		//Validacion para el nombre
		if (nombreInsumo == "") {
			document.getElementById('errorNombreEditar').style.display = 'inline';
			document.getElementById('nombreInsumoEditar').style.border = "1px solid red";
		} else {
			document.getElementById('errorNombreEditar').style.display = 'none';
			document.getElementById('nombreInsumoEditar').style.border = "";
		}

		//Validacion para el tipo
		if (tipoSeleccionado == "Seleccione Tipo") {
			document.getElementById('errorTipoEditar').style.display = 'inline';
			document.getElementById('tipoInsumoEditar').style.border = "1px solid red";
		} else {
			document.getElementById('errorTipoEditar').style.display = 'none';
			document.getElementById('tipoInsumoEditar').style.border = "";
		}

		//Validacion para la unidad de medida
		if (umSeleccionado == "Seleccione Unidad de Medida") {
			document.getElementById('errorUMEditar').style.display = 'inline';
			document.getElementById('umInsumoEditar').style.border = "1px solid red";
		} else {
			document.getElementById('errorUMEditar').style.display = 'none';
			document.getElementById('umInsumoEditar').style.border = "";
		}

		if (nombreInsumo != "" && tipoSeleccionado != "Seleccione Tipo"
				&& umSeleccionado != "Seleccione Unidad de Medida" && idInsumo>0) {
			$.ajax({
				type : 'POST',
				url : "editarInsumo",
				dataType : 'json',
				data : {
					idInsumo:idInsumo,
					nombre : nombreInsumo,
					tipo : tipoSeleccionado,
					um : umSeleccionado,
					marca : marca
				},
				success : function(data) {
					console.log(data);

					if(data==true){
						
						//Actualizar el data table
						 $.ajax({
								type : 'POST',
								url : "obtenerListaInsumos",
								dataType : 'json',
								success : function(data) {
									
									if(!$.isEmptyObject(data)){
										//vaciar datatable
										var oTable = $('#listaInsumos').dataTable();
										oTable.fnClearTable();
										
										//Llenar data table
										for(var i=0;i<data.length;i++){
											$('#listaInsumos').dataTable().fnAddData(

													[i + 1, data[i].nombre, data[i].tipo,
															data[i].unidadMedida, data[i].marca, '<a href="#" onclick="editarInsumo('+data[i].idInsumo+');"><i class="fa fa-edit fa-lg" style="color: #1CE4D0"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" onclick="eliminarInsumo('+data[i].idInsumo+');"><i class="fa fa-trash-o fa-lg" style="color: red"></i></a>' ]

											);
										}
									}
									
									//Close modal
									$('#modalEditarInsumo').modal('hide');
									

								},
								error : function(jqXHR, errorThrown) {
									toastr.error("Error al obtener los insumos");
								}
							});
						
						
						
					}else{
						toastr.error("Error al editar el insumo");
					}

				},
				error : function(jqXHR, errorThrown) {
					toastr.error("Error al editar el insumo");
				}
			});
		}

	}
</script>


<script>
	$('#listaInsumos').DataTable({
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