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
							<h3 class="box-title">Registrar Actividad Realizada</h3>

							<label class="pull-right" style="font-weight: normal; color: red">*
								Campos obligatorios</label>

						</div>
						<!-- /.box-header -->
						<div class="box-body">
							<div id="filtros" class="row">
								<div class="form-group">

									<div class="col-md-3 col-sm-6 col-xs-12">
										<label>* Sector</label> <select id="sector"
											class="form-control select2 select2-hidden-accessible"
											onchange="buscarPrediosSector();">

											<option value="-1">Seleccione un sector</option>
											<c:forEach var="listaSectores" items="${listaSectores}">

												<option value="${listaSectores.idSector}">${listaSectores.nombre}</option>

											</c:forEach>


										</select> <span id="errorSector" class="error" style="display: none">Seleccione
											un sector</span> <span id="sinPredio" class="error"
											style="display: none">Sector no tiene predios con
											planes asignados o todos sus predios están cosechados</span>
									</div>

									<div class="col-md-3 col-sm-6 col-xs-12" id="divPredio"
										style="display: none">
										<label>* Predio</label> <select id="predio"
											class="form-control select2 select2-hidden-accessible"
											onchange="mostrarActividades();">

										</select> <span id="errorPredio" class="error" style="display: none">Seleccione
											un predio</span>
									</div>

									<div class="col-md-3" id="divPlanAsignado"
										style="display: none">
										<label>Plan Asignado al Predio</label> <input
											id="planAsignado"
											class="form-control select2 select2-hidden-accessible"
											disabled />


									</div>


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

			<div id="divTablaRegistrarActividadRealizada" style="display: none">

				<div class="row">
					<div class="col-xs-12">
						<div class="box box-primary">
							<div class="box-header">
								<h3 class="box-title">Actividades del Plan Asignado al
									Predio</h3>

							</div>
							<!-- /.box-header -->
							<div class="box-body">
								<div class="row">
									<div class="col-sm-3"></div>

									<div class="col-sm-12">

										<table id="tablaActividades"
											class="table table-striped table-bordered table-hover">

											<thead>
												<tr>

													<th>N°</th>
													<th width="400px">Nombre Actividad</th>
													<th>Fecha Estimada</th>
													<th>Fecha Ejecución Real</th>
													<th>Cantidad Cosechada</th>
													<th>Insumos Utilizados</th>
													<th>id actividad</th>

												</tr>
											</thead>

										</table>

									</div>
									<div class="col-sm-3"></div>

								</div>
								<br>

								<button id="botonGuardar" type="button"
									class="btn btn-primary pull-right" onclick="guardarDatos();">
									<i class="fa fa-save"> Guardar</i>
								</button>

							</div>
							<!-- /.box-body -->
						</div>
						<!-- /.box -->



						<!-- /.box -->
					</div>
					<!-- /.col -->
				</div>

			</div>

			<!-- Modal Agregar Insumo -->
			<div class="modal fade" id="modalAgregarInsumo" tabindex="-1"
				role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-lg" role="document">
					<div class="modal-content">
						<div class="modal-header">

							<h4 class="modal-title" id="myModalLabel">Asignar Insumo</h4>
						</div>
						<div class="modal-body">


							<div class="row">

								<div class="box-body">

									<div id="form-editar" class="form-group">

										<label class="col-sm-2 control-label">* Insumo</label>
										<div class="col-sm-6">
											<select id="insumo"
												class="form-control select2 select2-hidden-accessible"
												onchange="getUMInsumo();">

											</select> <span id="errorInsumo" class="error" style="display: none">Seleccione
												un insumo</span>
										</div>

										<div class="col-sm-2">
											<button class="btn btn-primary"
												onclick="abrirModalAgregarInsumoBD();">Agregar
												Insumo</button>
										</div>

										<div id="divUMInsumo" style="display: none">
											<br> <br> <label class="col-sm-2 control-label">Unidad
												de Medida</label>
											<div class="col-sm-6">
												<input type="text" class="form-control" id="umInsumo"
													disabled>
											</div>
										</div>

										<br> <br> <label class="col-sm-2 control-label">*
											Cantidad</label>
										<div class="col-sm-6">
											<input type="text" class="form-control" id="cantidadInsumo"
												onkeypress="return filterFloat(event,this);"> <span
												id="errorCantidadInsumo" class="error" style="display: none">Ingrese
												la cantidad de insumo utilizado</span> <span id="errorCantidadCero"
												class="error" style="display: none">La cantidad no
												puede ser 0</span>
										</div>


										<br> <br> <label class="col-sm-2 control-label">*
											Costo</label>
										<div class="col-sm-6">
											<input type="text" class="form-control" id="costoInsumo"
												onkeypress="return filterFloat(event,this);"> <span
												id="errorCostoInsumo" class="error" style="display: none">Ingrese
												el costo del insumo utilizado</span> <span id="errorCostoCero"
												class="error" style="display: none">El costo no puede
												ser 0</span>
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
									onclick="agregarInsumoAActividadRealizada();">Agregar</button>
							</div>
						</div>
					</div>
				</div>
			</div>

			<!-- Modal Ver Insumos Utilizados -->
			<div class="modal fade" id="modalVerInsumos" tabindex="-1"
				role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog  modal-lg" role="document">
					<div class="modal-content">
						<div class="modal-header">

							<h4 class="modal-title">Insumos utilizados en la Actividad</h4>

						</div>
						<div class="modal-body">


							<div class="row">

								<div class="box-body">

									<table id="listaInsumos"
										class="table table-striped table-bordered table-hover">

										<thead>
											<tr>
												<th width="25px">N°</th>
												<th>Nombre Insumo</th>
												<th>Tipo</th>
												<th>Unidad de Medida</th>
												<th>Marca</th>
												<th>Cantidad</th>
												<th>Costo</th>
												<th>Acción</th>


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



			<!-- Modal Ver Insumos Utilizados -->
			<div class="modal fade" id="modalVerInsumosDespuesDeGuardar"
				tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
				aria-hidden="true">
				<div class="modal-dialog  modal-lg" role="document">
					<div class="modal-content">
						<div class="modal-header">

							<h4 class="modal-title">Insumos utilizados en la Actividad</h4>

						</div>
						<div class="modal-body">


							<div class="row">

								<div class="box-body">

									<table id="listaInsumosDespuesDeGuardar"
										class="table table-striped table-bordered table-hover">

										<thead>
											<tr>
												<th width="25px">N°</th>
												<th>Nombre Insumo</th>
												<th>Tipo</th>
												<th>Unidad de Medida</th>
												<th>Marca</th>
												<th>Cantidad</th>
												<th>Costo</th>



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


			<!-- Modal Editar insumo utilizado -->
			<div class="modal fade" id="modalEditarInsumo" tabindex="-1"
				role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">

							<h4 class="modal-title" id="myModalLabel">Editar Insumo
								Utilizado en la Actividad</h4>
						</div>
						<div class="modal-body">


							<div class="row">

								<div class="box-body">

									<div id="form-editar" class="form-group">

										<label class="col-sm-4 control-label">Insumo</label>
										<div class="col-sm-6">
											<input id="insumoEditar" class="form-control" disabled />
										</div>


										<br> <br> <label class="col-sm-4 control-label">Unidad
											de Medida</label>
										<div class="col-sm-6">
											<input type="text" class="form-control" id="umInsumoEditar"
												disabled>
										</div>


										<br> <br> <label class="col-sm-4 control-label">*
											Cantidad</label>
										<div class="col-sm-6">
											<input type="text" class="form-control"
												id="cantidadInsumoEditar"> <span
												id="errorCantidadInsumoEditar" class="error"
												style="display: none">Ingrese la cantidad de insumo
												utilizado</span> <span id="errorCantidadCeroEditar" class="error"
												style="display: none">La cantidad no puede ser 0</span>
										</div>


										<br> <br> <label class="col-sm-4 control-label">*
											Costo</label>
										<div class="col-sm-6">
											<input type="text" class="form-control"
												id="costoInsumoEditar"> <span
												id="errorCostoInsumoEditar" class="error"
												style="display: none">Ingrese el costo del insumo
												utilizado</span> <span id="errorCostoCeroEditar" class="error"
												style="display: none">El costo no puede ser 0</span>
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
									onclick="guardarInsumoEditado();">Actualizar</button>
							</div>
						</div>
					</div>
				</div>
			</div>


			<!-- Modal agregar insumo bd -->
			<div class="modal fade" id="modalAgregarInsumoBD" tabindex="-1"
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

										<label class="col-sm-4 control-label">* Nombre</label>
										<div class="col-sm-6">
											<input type="text" class="form-control" id="nombreInsumo">
											<span id="errorNombre" class="error" style="display: none">Ingrese
												el nombre del insumo</span>
										</div>
										<br> <br> <label class="col-sm-4 control-label">*
											Tipo</label>
										<div class="col-sm-6">
											<select class="form-control" id="tipoInsumo">
												<option value="-1">Seleccione Tipo</option>
												<option value="1">Combustible</option>
												<option value="2">Semilla</option>
												<option value="3">Abono</option>
												<option value="4">Fertilizante</option>
												<option value="5">Herbicida</option>

											</select> <span id="errorTipo" class="error" style="display: none">Seleccione
												el tipo de insumo</span>
										</div>

										<br> <br> <label class="col-sm-4 control-label">*
											Unidad de Medida</label>

										<div class="col-sm-6">
											<select class="form-control" id="umInsumoBD">
												<option value="-1">Seleccione Unidad de Medida</option>
												<option value="1">Kilogramo</option>
												<option value="2">Litro</option>
												<option value="3">Unidad</option>

											</select> <span id="errorUM" class="error" style="display: none">Seleccione
												la unidad de medida</span>
										</div>
										<br> <br> <label class="col-sm-4 control-label">&nbsp;&nbsp;&nbsp;Marca</label>

										<div class="col-sm-6">
											<input type="text" class="form-control" id="marcaInsumo">
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
									onclick="guardarDatosInsumo();">Agregar</button>
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
	function buscarPrediosSector() {

		var idSector = $('#sector').val();
		console.log(idSector);

		if (idSector > 0) {
			document.getElementById('errorSector').style.display = 'none';
			document.getElementById('sector').style.border = "";
			document.getElementById('divTablaRegistrarActividadRealizada').style.display = 'none';
			document.getElementById('divPlanAsignado').style.display = 'none';
			//Obtener los predios
			$
					.ajax({
						type : 'POST',
						url : "obtenerPrediosDelSectorConPlanAsignado",
						dataType : 'json',
						data : {
							idSector : idSector
						},
						success : function(data) {

							if (!$.isEmptyObject(data)) {
								document.getElementById('sector').style.border = "";
								document.getElementById('sinPredio').style.display = 'none';
								//Contruir el proximo select predio
								//Vaciar select
								$("#predio").empty();
								$("#predio")
										.append(
												'<option value="-1">Seleccione un predio</option>');
								for (var i = 0; i < data.length; i++) {
									$("#predio").append(
											'<option value='+data[i].idPredio+'>'
													+ data[i].nombre
													+ '</option>');

								}

								document.getElementById('divPredio').style.display = 'inline';

							} else {
								document.getElementById('divPredio').style.display = 'none';
								document.getElementById('sector').style.border = "1px solid red";
								document.getElementById('sinPredio').style.display = 'inline';
								document.getElementById('divPlanAsignado').style.display = 'none';
								document
										.getElementById('divTablaRegistrarActividadRealizada').style.display = 'none';
							}
						},
						error : function(jqXHR, errorThrown) {
							alert("Error al obtener los predios");
						}
					});

		} else {
			document.getElementById('errorSector').style.display = 'inline';
			document.getElementById('divPredio').style.display = 'none';
			document.getElementById('sector').style.border = "1px solid red";
			document.getElementById('divPlanAsignado').style.display = 'none';
			document.getElementById('sinPredio').style.display = 'none';
			document.getElementById('divTablaRegistrarActividadRealizada').style.display = 'none';
		}

	}

	function mostrarActividades() {
		//Vaciar tabla
		var oTableIngre = document.getElementById('tablaActividades');

		//gets rows of table
		var rowLengthoTableIngre = oTableIngre.rows.length;

		for (t = 1; t < rowLengthoTableIngre; t++) {
			var Table = document.getElementById('tablaActividades');
			if (Table.rows.length > 0) {
				Table.deleteRow(1);

			}
		}

		var contActividadesRealizadas = 0;

		//obtener el id del predio
		var idPredio = $('#predio').val();
		if (idPredio > 0) {
			$
					.ajax({
						type : 'POST',
						url : "obtenerActividadesDelPlanAsignadoAlPredio",
						dataType : 'json',
						data : {
							idPredio : idPredio
						},
						success : function(data) {
							console.log(data);
							if (!$.isEmptyObject(data)) {
								//Cargar los datos a la tabla
								for (var i = 0; i < data.length; i++) {
									//N° Filas
									var filas = document
											.getElementById("tablaActividades").rows.length;
									console.log("filas: " + filas);

									if (filas >= 1) {
										//Agregar el nombre de la actividad a la tabla

										//numero
										var num = 0;
										var oTable = document
												.getElementById('tablaActividades');

										var rowLength = oTable.rows.length;
										var oCells = oTable.rows
												.item(rowLength - 1).cells;
										var n = oCells[0].textContent;

										if (n == "N°") {
											num = 1;
										} else {
											num = parseInt(n) + 1;
										}

										// Find a <table> element with id="myTable":
										var table = document
												.getElementById("tablaActividades");

										// Create an empty <tr> element and add it to the 1st position of the table:
										var row = table.insertRow(filas);

										// Insert new cells (<td> elements) at the 1st and 2nd position of the "new" <tr> element:
										var cell1 = row.insertCell(0);
										var cell2 = row.insertCell(1);
										var cell3 = row.insertCell(2);
										var cell4 = row.insertCell(3);
										var cell5 = row.insertCell(4);
										var cell6 = row.insertCell(5);
										var cell7 = row.insertCell(6);
										var cell8 = row.insertCell(7);

										// Add some text to the new cells:
										cell1.innerHTML = num;
										cell2.innerHTML = data[i].actividad.nombre;

										var fecha = moment(
												data[i].fechaEstimada,
												'YYYY/MM/DD');
										fecha = fecha.format('DD-MM-YYYY');
										cell3.innerHTML = fecha;

										var idFecha = "fechaEjecucion" + num;

										var max = new Date();

										fechaMax = moment(max, 'YYYY/MM/DD');
										fechaMax = fechaMax
												.format('YYYY-MM-DD');

										var fechaMin = moment(
												data[i].temporada.fechaInicio,
												'YYYY/MM/DD');

										fechaMin = fechaMin
												.format('YYYY-MM-DD');

										console.log(fechaMin);

										if (data[i].fechaEjecucionReal == null) {
											cell4.innerHTML = '<input type="date" id="'+idFecha+'" min="'+fechaMin+'" max="'+fechaMax+'" class="form-control select2 select2-hidden-accessible"/>';

										} else {
											fecha = moment(
													data[i].fechaEjecucionReal,
													'YYYY/MM/DD');
											fecha = fecha.format('DD-MM-YYYY');
											cell4.innerHTML = fecha;

											contActividadesRealizadas++;
										}

										cell6.innerHTML = '<a href="#" title="Agregar Insumo" onclick="agregarInsumos('
												+ data[i].idActividadRealizada
												+ ');">	<i class="fa fa-plus-circle fa-lg" style="color: #F27812"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" title="Ver Insumos Utilizados" onclick="verInsumosUtilizados('
												+ data[i].idActividadRealizada
												+ ');"><i class="fa fa-eye fa-lg" style="color: blue"></i></a>';

										if (data[i].actividad.actividadCosecha == true) {
											if (data[i].fechaEjecucionReal == null) {
												cell5.innerHTML = '<input type="number" id="cantidadCosechada" onkeypress="return filterFloat(event,this);" class="form-control select2 select2-hidden-accessible">';
											} else {
												cell5.innerHTML = currency(
														data[i].cantidadCosechada,
														1)
														+ " Kg.";
											}
											cell8.innerHTML = 1;

										} else {
											cell5.innerHTML = "";
											cell8.innerHTML = 0;
										}

										cell7.innerHTML = data[i].idActividadRealizada;

										$('#planAsignado')
												.val(
														data[i].actividad.planEjecucion.nombre);

									}

								}

								//Ocultar la columna id actividad
								var tbl = document
										.getElementById("tablaActividades");
								for (var i = 0; i < tbl.rows.length; i++) {

									for (var j = 0; j < tbl.rows[i].cells.length; j++) {

										tbl.rows[i].cells[j].style.display = "";

										if (j == 6)

											tbl.rows[i].cells[j].style.display = "none";
										if (j == 7)

											tbl.rows[i].cells[j].style.display = "none";

									}

								}

								//ocultar columna cosecha

								document.getElementById('divPlanAsignado').style.display = 'inline';
								document
										.getElementById('divTablaRegistrarActividadRealizada').style.display = 'inline';

								if (contActividadesRealizadas == data.length) {
									document.getElementById('botonGuardar').style.display = 'none';
								} else {
									document.getElementById('botonGuardar').style.display = 'inline';
								}
							}
						},
						error : function(jqXHR, errorThrown) {
							alert("Error al obtener las actividades del plan asignado al predio seleccionado");
						}
					});
		} else {
			document.getElementById('divPlanAsignado').style.display = 'none';
			document.getElementById('divTablaRegistrarActividadRealizada').style.display = 'none';
		}
	}

	function agregarInsumos(idActividad) {

		//Guardar el id de la actividad en memoria local
		localStorage.setItem("idActividad", idActividad);

		$('#insumo').empty();
		$('#umInsumo').val("");
		$('#cantidadInsumo').val("");
		$('#costoInsumo').val("");

		document.getElementById('errorInsumo').style.display = 'none';
		document.getElementById('insumo').style.border = "";

		document.getElementById('errorCantidadInsumo').style.display = 'none';
		document.getElementById('cantidadInsumo').style.border = "";

		document.getElementById('errorCostoInsumo').style.display = 'none';
		document.getElementById('costoInsumo').style.border = "";

		document.getElementById('divUMInsumo').style.display = 'none';

		//Obtener todos los insumos para cargarlos en el select

		$.ajax({
			type : 'POST',
			url : "obtenerListaInsumos",
			dataType : 'json',
			success : function(data) {
				console.log(data);
				//Cargar los datos en el select
				$("#insumo").append(
						'<option value="-1">Seleccione un insumo</option>');
				for (var i = 0; i < data.length; i++) {
					$("#insumo").append(
							'<option value='+data[i].idInsumo+'>'
									+ data[i].nombre + '</option>');

				}

				//Mostrar modal
				$('#modalAgregarInsumo').modal('show');
			},
			error : function(jqXHR, errorThrown) {
				alert("Error al obtener los insumos");
			}

		});

	}

	function getUMInsumo() {

		//Obtener id del insumo seleccionado
		var idInsumo = $('#insumo').val();

		if (idInsumo == -1) {
			document.getElementById('divUMInsumo').style.display = 'none';
		} else {
			document.getElementById('errorInsumo').style.display = 'none';
			document.getElementById('insumo').style.border = "";

			if (idInsumo > 0) {
				//Buscar insumo
				$
						.ajax({
							type : 'POST',
							url : "obtenerInsumoAEditar",
							dataType : 'json',
							data : {
								idInsumo : idInsumo
							},
							success : function(data) {
								console.log(data);
								if (!$.isEmptyObject(data)) {

									//Cargar um
									$('#umInsumo').val(data.unidadMedida);

									//Mostrar div insumo
									document.getElementById('divUMInsumo').style.display = 'inline';

								}
							},
							error : function(jqXHR, errorThrown) {
								alert("Error al obtener datos del insumo seleccionado");
							}
						});
			}
		}

	}

	function agregarInsumoAActividadRealizada() {
		//Obtener los valores
		var idInsumo = $('#insumo').val();
		var cantidad = $('#cantidadInsumo').val();
		var costo = $('#costoInsumo').val();

		if (idInsumo == -1) {
			document.getElementById('errorInsumo').style.display = 'inline';
			document.getElementById('insumo').style.border = "1px solid red";
		} else {
			document.getElementById('errorInsumo').style.display = 'none';
			document.getElementById('insumo').style.border = "";
		}

		if (cantidad == "") {
			document.getElementById('errorCantidadInsumo').style.display = 'inline';
			document.getElementById('cantidadInsumo').style.border = "1px solid red";
		} else {
			if (cantidad == 0) {
				document.getElementById('errorCantidadInsumo').style.display = 'none';
				document.getElementById('errorCantidadCero').style.display = 'inline';
				document.getElementById('cantidadInsumo').style.border = "1px solid red";
			} else {
				document.getElementById('errorCantidadInsumo').style.display = 'none';
				document.getElementById('cantidadInsumo').style.border = "";
				document.getElementById('errorCantidadCero').style.display = 'none';
			}

		}

		if (costo == "") {
			document.getElementById('errorCostoInsumo').style.display = 'inline';
			document.getElementById('costoInsumo').style.border = "1px solid red";
		} else {
			if (costo == 0) {
				document.getElementById('errorCostoInsumo').style.display = 'none';
				document.getElementById('errorCostoCero').style.display = 'inline';
				document.getElementById('costoInsumo').style.border = "1px solid red";
			} else {
				document.getElementById('errorCostoInsumo').style.display = 'none';
				document.getElementById('costoInsumo').style.border = "";
				document.getElementById('errorCostoCero').style.display = 'none';
			}

		}

		if (idInsumo > 0 && cantidad != "" && cantidad > 0 && costo != ""
				&& costo > 0) {
			//Guardar los datos

			//Obtener el id de la actividad
			var idActividadRealizada = localStorage.getItem("idActividad");
			console.log(idActividadRealizada);

			if (idActividadRealizada > 0) {

				//Guardar los datos
				$
						.ajax({
							type : 'POST',
							url : "guardarDatosInsumoUtilizado",
							dataType : 'json',
							data : {
								idActividadRealizada : idActividadRealizada,
								idInsumo : idInsumo,
								cantidad : cantidad,
								costo : costo
							},
							success : function(data) {
								console.log(data);
								if (data == true) {
									toastr
											.success("Insumo agregado correctamente a la actividad");
									//Vaciar los campos del modal por si el usuario quiere seguir ingresando insumos utilizados
									$('#insumo').val(-1);
									document.getElementById('divUMInsumo').style.display = 'none';
									$('#cantidadInsumo').val("");
									$('#costoInsumo').val("");
								} else {
									toastr
											.error("Error al agregar el insumo a la actividad");
								}
							},
							error : function(jqXHR, errorThrown) {
								alert("Error al guardar el insumo");
							}
						});
			}
		}

	}

	function verInsumosUtilizados(idActividad) {
		if (idActividad > 0) {
			//Buscar los insumos utilizados en la actividad
			localStorage.setItem("idActividadRealizada", idActividad);
			$
					.ajax({
						type : 'POST',
						url : "obtenerInsumosUtilizadosEnLaActividad",
						dataType : 'json',
						data : {
							idActividad : idActividad
						},
						success : function(data) {
							console.log(data);
							//vaciar datatable
							var oTable = $('#listaInsumos').dataTable();
							oTable.fnClearTable();

							//vaciar datatable
							oTable = $('#listaInsumosDespuesDeGuardar')
									.dataTable();
							oTable.fnClearTable();
							if (!$.isEmptyObject(data)) {

								//Llenar data table
								for (var i = 0; i < data.length; i++) {

									$('#listaInsumos')
											.dataTable()
											.fnAddData(

													[
															i + 1,
															data[i].insumo.nombre,
															data[i].insumo.tipo,
															data[i].insumo.unidadMedida,
															data[i].insumo.marca,
															data[i].cantidad,
															"$  "
																	+ currency(
																			data[i].costo,
																			1),
															'<a href="#" onclick="editarInsumoUtilizado('
																	+ data[i].idActividadInsumo
																	+ ');"><i class="fa fa-edit fa-lg" style="color: #1CE4D0"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" onclick="eliminarInsumoUtilizado('
																	+ data[i].idActividadInsumo
																	+ ');"><i class="fa fa-trash-o fa-lg" style="color: red"></i></a>' ]

											);

									//Mostrar modal
									$('#modalVerInsumos').modal('show');

								}

							} else {
								//Mostrar modal
								$('#modalVerInsumos').modal('show');
							}

						},
						error : function(jqXHR, errorThrown) {
							alert("Error al obtener los productos");
						}
					});
		}
	}

	function eliminarInsumoUtilizado(idActividadInsumo) {

		if (idActividadInsumo > 0) {
			swal(
					{
						title : "¿Está seguro de eliminar el insumo utilizado en la actividad?",
						text : "Esta acción no podrá ser recuperada",
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
									url : "eliminarInsumoUtilizadoEnLaActividad",
									dataType : 'json',
									data : {
										idActividadInsumo : idActividadInsumo
									},
									success : function(data) {
										if (data == true) {
											toastr
													.success("Insumo eliminado correctamente de la actividad realizada");
											swal.close();

											//Recargar tabla
											//Actualizar el data table
											var idActividad = localStorage
													.getItem("idActividadRealizada");
											$
													.ajax({
														type : 'POST',
														url : "obtenerInsumosUtilizadosEnLaActividad",
														dataType : 'json',
														data : {
															idActividad : idActividad
														},
														success : function(data) {
															console.log(data);
															//vaciar datatable
															var oTable = $(
																	'#listaInsumos')
																	.dataTable();
															oTable
																	.fnClearTable();
															if (!$
																	.isEmptyObject(data)) {

																//Llenar data table
																for (var i = 0; i < data.length; i++) {

																	$(
																			'#listaInsumos')
																			.dataTable()
																			.fnAddData(

																					[
																							i + 1,
																							data[i].insumo.nombre,
																							data[i].insumo.tipo,
																							data[i].insumo.unidadMedida,
																							data[i].insumo.marca,
																							data[i].cantidad,
																							"$  "
																									+ currency(
																											data[i].costo,
																											1),
																							'<a href="#" onclick="editarInsumoUtilizado('
																									+ data[i].idActividadInsumo
																									+ ');"><i class="fa fa-edit fa-lg" style="color: #1CE4D0"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" onclick="eliminarInsumoUtilizado('
																									+ data[i].idActividadInsumo
																									+ ');"><i class="fa fa-trash-o fa-lg" style="color: red"></i></a>' ]

																			);

																}

															}

														},
														error : function(jqXHR,
																errorThrown) {
															alert("Error al obtener los productos");
														}
													});

										} else {
											toastr
													.error("Error al eliminar el insumo asignado a la actividad");
										}

									},
									error : function(jqXHR, errorThrown) {
										toastr
												.error("Error al eliminar el plan");
									}
								});

					});
		}
	}

	function editarInsumoUtilizado(idActividadInsumo) {
		if (idActividadInsumo > 0) {
			//Obtener los datos de la actividadInsumo
			localStorage.setItem("idActividadInsumo", idActividadInsumo);
			$.ajax({
				type : 'POST',
				url : "obtenerDatosActividadInsumo",
				data : {
					idActividadInsumo : idActividadInsumo
				},
				dataType : 'json',
				success : function(data) {
					console.log(data);

					//Mostrar datos
					$('#insumoEditar').val(data.insumo.nombre);
					$('#umInsumoEditar').val(data.insumo.unidadMedida);
					$('#cantidadInsumoEditar').val(data.cantidad);
					$('#costoInsumoEditar').val(data.costo);

					//Mostrar Modal
					$('#modalEditarInsumo').modal("show");

				},
				error : function(jqXHR, errorThrown) {
					alert("Error al obtener los productos");
				}
			});
		}
	}

	function guardarInsumoEditado() {
		//obtener el id actividad insumo
		var idActividadInsumo = localStorage.getItem("idActividadInsumo");

		var cantidad = $('#cantidadInsumoEditar').val();
		var costo = $('#costoInsumoEditar').val();

		if (cantidad == "") {
			document.getElementById('errorCantidadInsumoEditar').style.display = 'inline';
			document.getElementById('cantidadInsumoEditar').style.border = "1px solid red";
		} else {
			if (cantidad == 0) {
				document.getElementById('errorCantidadInsumoEditar').style.display = 'none';
				document.getElementById('errorCantidadCeroEditar').style.display = 'inline';
				document.getElementById('cantidadInsumoEditar').style.border = "1px solid red";
			} else {
				document.getElementById('errorCantidadInsumoEditar').style.display = 'none';
				document.getElementById('cantidadInsumoEditar').style.border = "";
				document.getElementById('errorCantidadCeroEditar').style.display = 'none';
			}

		}

		if (costo == "") {
			document.getElementById('errorCostoInsumoEditar').style.display = 'inline';
			document.getElementById('costoInsumoEditar').style.border = "1px solid red";
		} else {
			if (costo == 0) {
				document.getElementById('errorCostoInsumoEditar').style.display = 'none';
				document.getElementById('errorCostoCeroEditar').style.display = 'inline';
				document.getElementById('costoInsumoEditar').style.border = "1px solid red";
			} else {
				document.getElementById('errorCostoInsumoEditar').style.display = 'none';
				document.getElementById('costoInsumoEditar').style.border = "";
				document.getElementById('errorCostoCeroEditar').style.display = 'none';
			}

		}

		if (idActividadInsumo > 0 && cantidad != "" && cantidad > 0
				&& costo != "" && costo > 0) {

			//Actualizar datos
			$
					.ajax({
						type : 'POST',
						url : "actualizarInsumoUtilizadoEnActividad",
						dataType : 'json',
						data : {
							idActividadInsumo : idActividadInsumo,
							cantidad : cantidad,
							costo : costo
						},
						success : function(data) {
							console.log(data);
							if (data == true) {
								toastr
										.success("El insumo utilizado fue editado correctamente");

								//Recargar Data Table
								//Actualizar el data table
								var idActividad = localStorage
										.getItem("idActividadRealizada");
								$
										.ajax({
											type : 'POST',
											url : "obtenerInsumosUtilizadosEnLaActividad",
											dataType : 'json',
											data : {
												idActividad : idActividad
											},
											success : function(data) {
												console.log(data);
												//vaciar datatable
												var oTable = $('#listaInsumos')
														.dataTable();
												oTable.fnClearTable();
												if (!$.isEmptyObject(data)) {

													//Llenar data table
													for (var i = 0; i < data.length; i++) {

														$('#listaInsumos')
																.dataTable()
																.fnAddData(

																		[
																				i + 1,
																				data[i].insumo.nombre,
																				data[i].insumo.tipo,
																				data[i].insumo.unidadMedida,
																				data[i].insumo.marca,
																				data[i].cantidad,
																				"$  "
																						+ currency(
																								data[i].costo,
																								1),
																				'<a href="#" onclick="editarInsumoUtilizado('
																						+ data[i].idActividadInsumo
																						+ ');"><i class="fa fa-edit fa-lg" style="color: #1CE4D0"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" onclick="eliminarInsumoUtilizado('
																						+ data[i].idActividadInsumo
																						+ ');"><i class="fa fa-trash-o fa-lg" style="color: red"></i></a>' ]

																);

													}

												}
												//Mostrar modal
												$('#modalEditarInsumo').modal(
														'hide');
											},
											error : function(jqXHR, errorThrown) {
												alert("Error al obtener los productos");
											}
										});

							} else {
								toastr
										.error("Error al editar el insumo utilizado");
							}
						},
						error : function(jqXHR, errorThrown) {
							alert("Error al obtener los productos");
						}
					});

		}
	}

	function guardarDatos() {
		//Recorrer Tabla y Guardar los datos en un arreglo

		//obtener los dato de la tabla
		var oTable = document.getElementById('tablaActividades');
		//gets rows of table
		var rowLength = oTable.rows.length;
		console.log(rowLength);
		var cont = 0;

		var arregloDatos = Array();
		var arregloDatosCosecha = Array();

		if (rowLength > 1) {
			//loops through rows    
			for (i = 1; i < rowLength; i++) {
				var oCells = oTable.rows.item(i).cells;//devuelve un objeto con la fila completa
				console.log(oCells[0].innerHTML);//Numero Fila
				console.log(oCells[1].innerHTML);//Nombre Actividad
				console.log(oCells[2].innerHTML);//Fecha Estimada

				console.log(oCells[4].innerHTML);//Cantidad cosechada
				console.log(oCells[6].innerHTML);//Id Actividad

				var idFecha = "fechaEjecucion" + oCells[0].innerHTML;
				var fecha = $('#' + idFecha).val();
				console.log("fecha: " + fecha);

				if (typeof fecha != 'undefined' && fecha != "") {
					console.log("fecha Ejecucion: " + fecha); //Imprimir Fecha Ejecucion Real
					cont++;

					//Agregar los datos en un arreglo

					if (oCells[7].innerHTML == 1) {
						var cantCosechada = $('#cantidadCosechada').val();
						if (cantCosechada == "") {
							toastr
									.warning("Debe ingresar la cantidad cosechada");
							$('#cantidadCosechada').focus();
							break;
						} else {
							fecha = moment(fecha, 'YYYY-MM-DD');
							fecha = fecha.format('DD-MM-YYYY');

							arregloDatosCosecha.push(oCells[6].innerHTML);//id actividad
							arregloDatosCosecha.push(fecha);//fecha ejecucion real
							arregloDatosCosecha.push(cantCosechada);//Cantidad Cosechada

						}

					} else {
						//la actividad no es cosecha por lo tanto se guarda en otro arreglo
						fecha = moment(fecha, 'YYYY-MM-DD');
						fecha = fecha.format('DD-MM-YYYY');
						arregloDatos.push(oCells[6].innerHTML);//id actividad
						arregloDatos.push(fecha);//fecha ejecucion real
					}

				}

				//agregar al arreglo los datos

			}
		}

		console.log(arregloDatos);
		console.log(arregloDatosCosecha);

		if (cont == 0) {
			toastr
					.warning("Debe indicar la fecha de ejecución real por lo menos en una actividad");
		} else {

			if (arregloDatos.length > 0 || arregloDatosCosecha.length > 0) {
				//Recorrer nuevamente el arreglo para preguntar si agregó insumos utilizados
				//Recorrer ambos arreglos
				var cont1 = 0, cont2 = 0;
				console.log(arregloDatos);
				if (arregloDatos.length > 0) {
					var aux = 0;
					for (var i = 0; i < arregloDatos.length / 2; i++) {
						console.log("id " + arregloDatos[aux]);
						//Buscar si la actividad tiene insumos agregados
						$
								.ajax({
									type : 'POST',
									url : "verificarActividadInsumo",
									dataType : 'json',
									async : false,
									data : {
										idActividadRealizada : parseInt(arregloDatos[aux])
									},
									success : function(data) {
										console.log(data);
										if (data == false) {
											//Obtener nombre actividad
											$
													.ajax({
														type : 'POST',
														url : "obtenerDatosActividadRealizada",
														dataType : 'json',
														async : false,
														data : {
															idActividadRealizada : parseInt(arregloDatos[aux])
														},
														success : function(data) {
															console.log(data);
															toastr
																	.error("Debe agregar insumos a la actividad: "
																			+ data.actividad.nombre);
														},
														error : function(jqXHR,
																errorThrown) {
															alert("Error al obtener los de la actividad realizada");
														}
													});
											cont1 += 10000000;

										} else {
											cont1++;
										}

									},
									error : function(jqXHR, errorThrown) {
										alert("Error al buscar datos actividad_insumo");
									}
								});
						aux += 2;
					}
				}

				if (arregloDatosCosecha.length > 0) {
					var aux2 = 0;
					for (var i = 0; i < arregloDatosCosecha.length / 3; i++) {
						//Buscar si la actividad tiene insumos agregados
						$
								.ajax({
									type : 'POST',
									url : "verificarActividadInsumo",
									dataType : 'json',
									async : false,
									data : {
										idActividadRealizada : parseInt(arregloDatosCosecha[aux2])
									},
									success : function(data) {
										if (data == false) {
											//Obtener nombre actividad
											$
													.ajax({
														type : 'POST',
														url : "obtenerDatosActividadRealizada",
														dataType : 'json',
														async : false,
														data : {
															idActividadRealizada : parseInt(arregloDatosCosecha[aux2])
														},
														success : function(data) {
															console.log(data);
															toastr
																	.error("Debe agregar insumos a la actividad: "
																			+ data.actividad.nombre);
														},
														error : function(jqXHR,
																errorThrown) {
															alert("Error al obtener los de la actividad realizada");
														}
													});
											cont2 += 10000000;

										} else {
											cont2++;
										}

									},
									error : function(jqXHR, errorThrown) {
										alert("Error al buscar datos actividad_insumo");
									}
								});
						aux2 += 3;
					}
				}

				console.log(cont1);
				console.log(cont2);
				console.log(arregloDatos.length);
				console.log(arregloDatosCosecha.length);
				//guardar los datos de arregloDatos
				if (cont1 == arregloDatos.length / 2 && arregloDatos.length > 0) {
					//Enviar arreglo
					$
							.ajax({
								type : 'POST',
								url : "guardarDatosActividadRealizada",
								dataType : 'json',
								async : false,
								data : {
									datos : arregloDatos
								},
								success : function(data) {
									if (data == true) {
										toastr
												.success("Actividad realizada registrada correctamente");
									} else {
										toastr
												.error("Error al registrar la actividad realizada");
									}
								},
								error : function(jqXHR, errorThrown) {
									alert("Error al guardar los datos");
								}
							});
				}

				//guardar los datos de arregloDatosCosecha
				if (cont2 == arregloDatosCosecha.length / 3
						&& arregloDatosCosecha.length > 0) {
					//Enviar arreglo
					$
							.ajax({
								type : 'POST',
								url : "guardarDatosActividadRealizadaCosecha",
								async : false,
								data : {
									datos : arregloDatosCosecha
								},
								dataType : 'json',
								success : function(data) {
									if (data == true) {
										toastr
												.success("Actividad realizada registrada correctamente");
									} else {
										toastr
												.error("Error al registrar la actividad realizada");
									}
								},
								error : function(jqXHR, errorThrown) {
									alert("Error al guardar los datos de cosecha");
								}
							});
				}

				//recargar pagina

				/*
				//ocultar div tabla
				document.getElementById('divTablaRegistrarActividadRealizada').style.display = 'none';

				//ocultar predio y plan
				document.getElementById('divPlanAsignado').style.display = 'none';
				document.getElementById('divPredio').style.display = 'none';

				$('#sector').val(-1);*/

				//recargar tabla actividades
				if (cont2 == (arregloDatosCosecha.length / 3)) {
					if (cont1 == (arregloDatos.length / 2)) {
						mostrarActividades();
					}
				}

			}

		}

	}

	function currency(value, decimals, separators) {
		decimals = decimals >= 0 ? parseInt(decimals, 0) : 2;
		separators = separators || [ '.', "'", ',' ];
		var number = (parseFloat(value) || 0).toFixed(decimals);
		if (number.length <= (4 + decimals))
			return number.replace('.', separators[separators.length - 1]);
		var parts = number.split(/[-.]/);
		value = parts[parts.length > 1 ? parts.length - 2 : 0];
		var result = value.substr(value.length - 3, 3)
				+ (parts.length > 1 ? separators[separators.length - 1]
						+ parts[parts.length - 1] : '');
		var start = value.length - 6;
		var idx = 0;
		while (start > -3) {
			result = (start > 0 ? value.substr(start, 3) : value.substr(0,
					3 + start))
					+ separators[idx] + result;
			idx = (++idx) % 2;
			start -= 3;
		}
		return (parts.length == 3 ? '-' : '') + result;
	}

	function abrirModalAgregarInsumoBD() {
		$('#modalAgregarInsumoBD').modal('show');

		//Limpiar modal
		$('#nombreInsumo').val("");
		$('#marcaInsumo').val("");
		$("#tipoInsumo").val(-1);
		$("#umInsumo").val(-1);

		document.getElementById('errorUM').style.display = 'none';
		document.getElementById('umInsumoBD').style.border = "";

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

		var um = document.getElementById("umInsumoBD");
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
			document.getElementById('umInsumoBD').style.border = "1px solid red";
		} else {
			document.getElementById('errorUM').style.display = 'none';
			document.getElementById('umInsumoBD').style.border = "";
		}

		if (nombreInsumo != "" && tipoSeleccionado != "Seleccione Tipo"
				&& umSeleccionado != "Seleccione Unidad de Medida") {
			$
					.ajax({
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
							if (!$.isEmptyObject(data)) {
								if (data.idInsumo > 0) {
									toastr
											.success("Insumo agregado correctamente");

									//Recargar select
									//Obtener todos los insumos para cargarlos en el select

									$
											.ajax({
												type : 'POST',
												url : "obtenerListaInsumos",
												dataType : 'json',
												success : function(data) {
													console.log(data);
													//Cargar los datos en el select
													$("#insumo").empty();
													$("#insumo")
															.append(
																	'<option value="-1">Seleccione un insumo</option>');
													for (var i = 0; i < data.length; i++) {
														$("#insumo")
																.append(
																		'<option value='+data[i].idInsumo+'>'
																				+ data[i].nombre
																				+ '</option>');

													}

													//ocultar modal
													$('#modalAgregarInsumoBD')
															.modal('hide');
												},
												error : function(jqXHR,
														errorThrown) {
													alert("Error al obtener los insumos");
												}

											});
								}
							}

						},
						error : function(jqXHR, errorThrown) {
							toastr.error("Error al agregar el insumo");
						}
					});
		}

	}

	function filterFloat(evt, input) {

		var key = window.Event ? evt.which : evt.keyCode;
		var chark = String.fromCharCode(key);
		var tempValue = input.value + chark;
		if (key >= 48 && key <= 57) {
			if (filter(tempValue) === false) {
				return false;
			} else {
				return true;
			}
		} else {
			if (key == 8 || key == 13 || key == 0) {
				return true;
			} else if (key == 46) {
				if (filter(tempValue) === false) {
					return false;
				} else {
					return true;
				}
			} else {
				return false;
			}
		}
	}

	function filter(__val__) {
		var preg = /^\d*$/;
		if (preg.test(__val__) === true) {
			return true;
		} else {
			return false;
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
			"sEmptyTable" : "No existen insumos asignados",
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

	$('#listaInsumosDespuesDeGuardar').DataTable({
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