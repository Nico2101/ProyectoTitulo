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
							<h3 class="box-title">Plan de Ejecución</h3>

							<label class="pull-right" style="font-weight: normal; color: red">*
								Campos obligatorios</label>

						</div>
						<!-- /.box-header -->
						<div class="box-body">
							<div id="filtros" class="row">
								<div class="form-group">

									<div class="col-md-3 col-sm-6 col-xs-12">
										<label>* Nombre del Plan</label><input id="nombrePlan"
											name="numeroOC" type="text"
											class="form-control select2 select2-hidden-accessible" /> <span
											id="errorNombrePlan" class="error" style="display: none">Ingrese
											el nombre del plan</span>
									</div>

									<div class="col-md-3 col-sm-6 col-xs-12">
										<label>* Fecha de Creación</label> <input id="fechaCreacion"
											type="date"
											class="form-control select2 select2-hidden-accessible"
											name="daterange" value="" /> <span id="errorFechaCreacion"
											class="error" style="display: none">Ingrese la fecha
											de creación</span> <span id="errorFechaCreacionMayor" class="error"
											style="display: none">La fecha no puede ser futura</span>
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


			<!-- Actividades -->
			<div class="row">
				<div class="col-xs-12">
					<div class="box box-primary">
						<div class="box-header">
							<h3 class="box-title">Actividades del Plan</h3>
							<button id="agregarActividad" type="button"
								class="btn btn-primary pull-right"
								onclick="modalAgregarActividad();">
								<i class="fa fa-plus-circle"> Agregar Actividad</i>
							</button>
						</div>
						<!-- /.box-header -->
						<div class="box-body">
							<div class="row">
								<div class="col-sm-3"></div>

								<div class="col-sm-6">
									<div align="center">
										<span id="errorTablaVacia" class="error" style="display: none">Debe
											agregar actividades</span>
									</div>
									<table id="tablaActividades"
										class="table table-striped table-bordered table-hover">

										<thead>
											<tr>

												<th>N°</th>
												<th>Nombre Actividad</th>
												<th>Acción</th>

											</tr>
										</thead>

									</table>

								</div>
								<div class="col-sm-3"></div>

							</div>
							<br>

							<button type="button" class="btn btn-primary pull-right"
								onclick="guardarDatos();">
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

			<!-- Modal Agregar Activiad -->
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

										<label class="col-sm-4 control-label">* Nombre
											Actividad</label>
										<div class="col-sm-6">
											<input type="text" class="form-control" id="nombreActividad">
											<span id="errorNombreActividad" class="error"
												style="display: none">Ingrese el nombre de la
												actividad</span>
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
									onclick="agregarDatosActividad();">Agregar</button>
							</div>
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

							<h4 class="modal-title" id="myModalLabel">Agregar Actividad</h4>
						</div>
						<div class="modal-body">


							<div class="row">

								<div class="box-body">

									<div id="form-editar" class="form-group">

										<label class="col-sm-4 control-label">* Nombre
											Actividad</label>
										<div class="col-sm-6">
											<input type="text" class="form-control"
												id="nombreActividadEditar"> <span
												id="errorNombreActividadEditar" class="error"
												style="display: none">Ingrese el nombre de la
												actividad</span>
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
									onclick="agregarActividadEditada();">Actualizar</button>
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
	function modalAgregarActividad() {
		$('#nombreActividad').val("");
		$('#modalAgregarActividad').modal('show');
		document.getElementById('errorNombreActividad').style.display = 'none';
		document.getElementById('nombreActividad').style.border = "";
		//$('#nombreActividad').focus();
	}

	function agregarDatosActividad() {
		var nombreActividad = $('#nombreActividad').val();

		if (nombreActividad == "") {
			document.getElementById('errorNombreActividad').style.display = 'inline';
			document.getElementById('nombreActividad').style.border = "1px solid red";
		} else {
			document.getElementById('errorNombreActividad').style.display = 'none';
			document.getElementById('nombreActividad').style.border = "";
		}

		if (nombreActividad != "") {
			//Agregar el dato de la actividad a la tabla

			//N° Filas
			var filas = document.getElementById("tablaActividades").rows.length;
			console.log("filas: " + filas);

			if (filas >= 1) {
				//Agregar el nombre de la actividad a la tabla

				//numero
				var num = 0;
				var oTable = document.getElementById('tablaActividades');

				var rowLength = oTable.rows.length;
				var oCells = oTable.rows.item(rowLength - 1).cells;
				var n = oCells[0].textContent;

				if (n == "N°") {
					num = 1;
				} else {
					num = parseInt(n) + 1;
				}

				// Find a <table> element with id="myTable":
				var table = document.getElementById("tablaActividades");

				// Create an empty <tr> element and add it to the 1st position of the table:
				var row = table.insertRow(filas);

				// Insert new cells (<td> elements) at the 1st and 2nd position of the "new" <tr> element:
				var cell1 = row.insertCell(0);
				var cell2 = row.insertCell(1);
				var cell3 = row.insertCell(2);

				// Add some text to the new cells:
				cell1.innerHTML = num;
				cell2.innerHTML = nombreActividad;
				cell3.innerHTML = '<a href="#" onclick="editarActividad('
						+ num
						+ ');"><i class="fa fa-edit fa-lg" style="color: #1CE4D0"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" onclick="eliminarActividad('
						+ num
						+ ');"><i class="fa fa-trash-o fa-lg" style="color: red"></i></a>';

				$('#nombreActividad').val("");
				$('#nombreActividad').focus();

			}
		}
	}

	function agregarActividadEditada() {
		var numFila = localStorage.getItem("numFila");
		console.log(numFila);

		var nombreActividad = $('#nombreActividadEditar').val();

		if (nombreActividad == "") {
			document.getElementById('errorNombreActividadEditar').style.display = 'inline';
			document.getElementById('nombreActividadEditar').style.border = "1px solid red";
		} else {
			document.getElementById('errorNombreActividadEditar').style.display = 'none';
			document.getElementById('nombreActividadEditar').style.border = "";
		}

		if (nombreActividad != "" && numFila > 0) {
			var oTable = document.getElementById('tablaActividades');
			//gets rows of table
			var rowLength = oTable.rows.length;

			//loops through rows    
			for (i = 0; i < rowLength; i++) {
				var oCells = oTable.rows.item(i).cells;//devuelve un objeto con la fila completa
				if (numFila == oCells[0].textContent) {
					oCells[1].innerHTML = nombreActividad;
				}
			}
		}
		
		$('#modalEditarActividad').modal('hide');
	}

	function editarActividad(numFila) {
		var oTable = document.getElementById('tablaActividades');
		//gets rows of table
		var rowLength = oTable.rows.length;

		//loops through rows    
		for (i = 0; i < rowLength; i++) {
			var oCells = oTable.rows.item(i).cells;//devuelve un objeto con la fila completa

			if (numFila == oCells[0].textContent) {
				var table = document.getElementById("tablaActividades");
				console.log("TABLE: ");
				console.log(table);
				if (table.rows.length > 0) {

					var num = numFila;

					var nombre = oCells[1].textContent;

					$('#nombreActividadEditar').val(nombre);
					document.getElementById('errorNombreActividadEditar').style.display = 'none';
					document.getElementById('nombreActividadEditar').style.border = "";

					localStorage.setItem("numFila", numFila);
					//mostrar el modal para editar la actividad
					$('#modalEditarActividad').modal('show');
				}
			}

		}
	}

	function eliminarActividad(numFila) {
		swal(
				{
					title : "¿Está seguro de eliminar la actividad?",
					text : "Esta acción no podrá ser recuperada",
					type : "warning",
					showCancelButton : true,
					confirmButtonClass : "btn-danger",
					cancelButtonText : "Cancelar",
					confirmButtonText : "Si, Eliminar",
					closeOnConfirm : false
				},
				function() {
					var oTable = document.getElementById('tablaActividades');

					//gets rows of table
					var rowLength = oTable.rows.length;

					var eliminado = false;
					//loops through rows    
					for (var i = 1; i < rowLength; i++) {
						var oCells = oTable.rows.item(i).cells;//devuelve un objeto con la fila completa

						if (numFila == oCells[0].textContent) {
							if (oTable.rows.length > 0) {
								console.log("valor de i: " + i);
								oTable.deleteRow(i);
								toastr.success("Se ha eliminado la fila N°: "
										+ numFila + " correctamente!");
								oTable = document
										.getElementById('tablaActividades');
								i = oTable.rows.length;
								eliminado = true;
							}
						}

						if (eliminado == true) {
							break;
						}

					}
					swal.close();

					//Actualizar numero de la tabla

					oTable = document.getElementById('tablaActividades');
					//gets rows of table
					rowLength = oTable.rows.length;

					for (var i = 1; i < rowLength; i++) {
						var oCells = oTable.rows.item(i).cells;//devuelve un objeto con la fila completa

						oCells[0].innerHTML = i;
						oCells[2].innerHTML = '<a href="#" onclick="editarActividad('
								+ i
								+ ');"><i class="fa fa-edit fa-lg" style="color: #1CE4D0"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" onclick="eliminarActividad('
								+ i
								+ ');"><i class="fa fa-trash-o fa-lg" style="color: red"></i></a>';

					}

				});

	}

	function guardarDatos() {

		//Obtener los datos del plan
		var nombrePlan = $('#nombrePlan').val();
		var fechaCreacion = $('#fechaCreacion').val();

		if (nombrePlan == "") {
			document.getElementById('errorNombrePlan').style.display = 'inline';
			document.getElementById('nombrePlan').style.border = "1px solid red";
		} else {
			document.getElementById('errorNombrePlan').style.display = 'none';
			document.getElementById('nombrePlan').style.border = "";
		}

		if (fechaCreacion == "") {
			document.getElementById('errorFechaCreacion').style.display = 'inline';
			document.getElementById('fechaCreacion').style.border = "1px solid red";
			document.getElementById('errorFechaCreacionMayor').style.display = 'none';
		} else {
			var fecha = new Date();
			fecha = moment(fecha, 'YYYY/MM/DD');
			fecha = fecha.format('DD-MM-YYYY');

			fechaC = moment(fechaCreacion, 'YYYY/MM/DD');
			fechaC = fechaC.format('DD-MM-YYYY');

			if (fechaC > fecha) {
				document.getElementById('errorFechaCreacion').style.display = 'none';
				document.getElementById('errorFechaCreacionMayor').style.display = 'inline';
				document.getElementById('fechaCreacion').style.border = "1px solid red";
			} else {
				document.getElementById('errorFechaCreacion').style.display = 'none';
				document.getElementById('fechaCreacion').style.border = "";
				document.getElementById('errorFechaCreacionMayor').style.display = 'none';
			}

		}

		var oTable = document.getElementById('tablaActividades');
		//gets rows of table
		var rowLength = oTable.rows.length;

		if (rowLength > 1) {
			document.getElementById('errorTablaVacia').style.display = 'none';
		} else {
			document.getElementById('errorTablaVacia').style.display = 'inline';
		}

		if (rowLength > 1 && nombrePlan != "" && fechaCreacion != "") {

			var arregloActividades = Array();

			//obtener las actividades de la tabla
			for (var i = 1; i < rowLength; i++) {
				var oCells = oTable.rows.item(i).cells;//devuelve un objeto con la fila completa
				arregloActividades.push(oCells[1].innerText);
			}

			console.log(arregloActividades);

			$
					.ajax({
						type : 'POST',
						url : "agregarPlanYActividades",
						dataType : 'json',
						data : {
							nombrePlan : nombrePlan,
							fecha : fechaCreacion,
							actividades : arregloActividades
						},
						success : function(data) {
							console.log(data);
							if (data == true) {
								toastr
										.success("El plan ha sido agregado correctamente");
								$('#nombrePlan').val("");
								$('#fechaCreacion').val("");

								//Vaciar tabla
								//Vaciar tabla materiales
								var ot = document
										.getElementById('tablaActividades');
								var tam = ot.rows.length;
								//loops through rows  
								var w = 0;
								for (w = 1; w < tam; w++) {
									var ot2 = document
											.getElementById('tablaActividades');
									if (ot2.rows.length > 0) {
										ot2.deleteRow(1);

									}
								}

							} else {
								toastr
										.error("Se ha producido un error al guardar el plan");
							}

						},
						error : function(jqXHR, errorThrown) {
							alert("Error al guardar el plan");
						}
					});

		}
	}
</script>

</html>