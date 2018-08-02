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
							<h3 class="box-title">Reprogramar Actividades</h3>

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

			<div id="divTablaActividades" style="display: none">

				<div class="row">
					<div class="col-xs-12">
						<div class="box box-primary">
							<div class="box-header">
								<h3 class="box-title">Actividades del Plan Asignado al
									Predio</h3>

							</div>
							<div class="box-header">
								<p>

									Las fechas nuevas estimadas ingresadas deben estar dentro de la
									duración de la temporada, las cuales corresponden : Fecha
									Inicio : <label id="fechaInicio"> </label> y Fecha Término : <label
										id="fechaTermino"> </label>
								</p>
							</div>
							<!-- /.box-header -->
							<div class="box-body">
								<div class="row">
									<div class="col-sm-2" style="text-align: center;"></div>

									<div class="col-sm-7">
										<table id="tablaActividades"
											class="table table-striped table-bordered table-hover">

											<thead>
												<tr>

													<th>N°</th>
													<th width="400px">Nombre Actividad</th>
													<th width="250px">Fecha Estimada</th>
													<th width="400px">Nueva Fecha Estimada</th>
													<th width="1200px">Motivo</th>
													<th>id actividad</th>

												</tr>

											</thead>

										</table>

									</div>
									<div class="col-sm-3"></div>

								</div>
								<br>

								<button id="botonGuardar" type="button"
									class="btn btn-primary pull-right"
									onclick="guardarDatosReprogramacionFecha();">
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
		document.getElementById('divPlanAsignado').style.display = 'none';
		document.getElementById('divTablaActividades').style.display = 'none';

		if (idSector > 0) {
			document.getElementById('errorSector').style.display = 'none';
			document.getElementById('sector').style.border = "";

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
								document.getElementById('divTablaActividades').style.display = 'none';
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
			document.getElementById('divTablaActividades').style.display = 'none';
		}

	}

	function mostrarActividades() {
		//Vaciar tabla
		var oTableIngre = document.getElementById('tablaActividades');
		var motivo = $('#motivo').val("");

		//gets rows of table
		var rowLengthoTableIngre = oTableIngre.rows.length;

		for (t = 1; t < rowLengthoTableIngre; t++) {
			var Table = document.getElementById('tablaActividades');
			if (Table.rows.length > 0) {
				Table.deleteRow(1);

			}
		}
		var contador = 0;
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
										var cell1 = row.insertCell(0); //numero
										var cell2 = row.insertCell(1);//nombre
										var cell3 = row.insertCell(2);//fechaEstimada
										var cell4 = row.insertCell(3);//nueva fecha estimada
										var cell5 = row.insertCell(4);//motivo
										var cell6 = row.insertCell(5);//idActividad
										//55

										// Add some text to the new cells:
										cell1.innerHTML = num;
										cell2.innerHTML = data[i].actividad.nombre;

										var fecha = moment(
												data[i].fechaEstimada,
												'YYYY/MM/DD');
										fecha = fecha.format('DD-MM-YYYY');

										cell3.innerHTML = fecha;

										/*fecha = moment(fecha, 'DD/MM/YYYY');
										var min = new Date(fecha);
										var dias = 1;
										min.setDate(min.getDate() + 1);
										console.log(min);
										fechaMin = moment(min, 'YYYY/MM/DD');
										fechaMin = fechaMin
												.format('YYYY-MM-DD');  */
										var fechaInicio = data[i].temporada.fechaInicio;
										var fechaTermino = data[i].temporada.fechaTermino;
										console.log(fechaInicio);
										console.log(fechaTermino);

										var idFecha = "fechaReprogramacion"
												+ num;
										var motivoReprogramacion = "motivo"
												+ num;

										if (data[i].fechaEjecucionReal == null) {
											cell4.innerHTML = '<input type="date" name="fecha" id="'+idFecha+'"  min="'+fechaInicio+'" max="'+fechaTermino+'" class="form-control select2 select2-hidden-accessible"/>';
											cell5.innerHTML = '<input type="text" name="motivo" id="'+motivoReprogramacion+'"   class="form-control select2 select2-hidden-accessible"/>';
										} else {
											fecha = moment(
													data[i].fechaEjecucionReal,
													'YYYY/MM/DD');
											fecha = fecha.format('DD-MM-YYYY');
											cell4.innerHTML = "Actividad realizada el "
													+ fecha;
											cell5.innerHTML = "";
											contador++;
										}

										cell6.innerHTML = data[i].idActividadRealizada;
										$('#planAsignado')
												.val(
														data[i].actividad.planEjecucion.nombre);

									}

								}

								fechaInicio = moment(fechaInicio, 'YYYY/MM/DD');
								fechaInicio = fechaInicio.format('DD-MM-YYYY');

								fechaTermino = moment(fechaTermino,
										'YYYY/MM/DD');
								fechaTermino = fechaTermino
										.format('DD-MM-YYYY');

								$("#fechaInicio").text(fechaInicio);
								$("#fechaTermino").text(fechaTermino);

								//Ocultar la columna id actividad
								var tbl = document
										.getElementById("tablaActividades");
								for (var i = 0; i < tbl.rows.length; i++) {

									for (var j = 0; j < tbl.rows[i].cells.length; j++) {

										tbl.rows[i].cells[j].style.display = "";

										if (j == 5)

											tbl.rows[i].cells[j].style.display = "none";

									}

								}
								if (contador == data.length) {
									document.getElementById('botonGuardar').style.display = 'none';
									
									//Ocultar FILA MOTIVO actividad
									var tbl = document
											.getElementById("tablaActividades");
									for (var i = 0; i < tbl.rows.length; i++) {

										for (var j = 0; j < tbl.rows[i].cells.length; j++) {

											tbl.rows[i].cells[j].style.display = "";

											if (j == 4)

												tbl.rows[i].cells[j].style.display = "none";
											
											if (j == 5)

												tbl.rows[i].cells[j].style.display = "none";

										}
										

									}
									
								}else{
									document.getElementById('botonGuardar').style.display = 'inline';
								}

								document.getElementById('divPlanAsignado').style.display = 'inline';
								document.getElementById('divTablaActividades').style.display = 'inline';

								//document.getElementById('errorMotivo').style.display = 'none';
								//document.getElementById('motivo').style.border = "";

							}
						},
						error : function(jqXHR, errorThrown) {
							alert("Error al obtener las actividades del plan asignado al predio seleccionado");
						}
					});
		} else {
			document.getElementById('divPlanAsignado').style.display = 'none';
			document.getElementById('divTablaActividades').style.display = 'none';
		}
	}

	function guardarDatosReprogramacionFecha() {
		//Recorrer Tabla y Guardar los datos en un arreglo

		//obtener los dato de la tabla
		var oTable = document.getElementById('tablaActividades');
		//gets rows of table
		var rowLength = oTable.rows.length;
		console.log(rowLength);
		var cont = 0;

		var arregloFechasEstimadas = Array();
		var arregloFechasReprogramadas = Array();
		var arregloFechasRealesReprogramadas = Array();
		var arregloIds = Array();
		var arregloFechasEstimadas = Array();
		var arreglosMotivos = Array();
		var arreglosMotivos2 = Array();

		var fechas = "";

		for (i = 1; i < rowLength; i++) { //Recorre las filas 1 a 1
			var idFecha = "fechaReprogramacion" + i;
			var idMotivo = "motivo" + i;

			var fecha = $('#' + idFecha).val();
			var motivo = $('#' + idMotivo).val();

			console.log(motivo);
			console.log(fecha);

			if (typeof fecha != 'undefined' && fecha != "") {
				arregloFechasReprogramadas.push($('#' + idFecha).val());

			}

			if (typeof motivo != 'undefined' && motivo != "") {
				arreglosMotivos.push($('#' + idMotivo).val());
			}

			if (typeof motivo != 'undefined' && typeof fecha != 'undefined'
					&& fecha != "" && motivo != "") {
				var oCells = oTable.rows.item(i).cells;//devuelve un objeto con la fila completa
				arregloFechasEstimadas.push(oCells[2].innerHTML);//fechas estimadas
				arregloIds.push(oCells[5].innerHTML);//almacena los ids
			}

		}

		console.log(arregloFechasReprogramadas);
		console.log(arreglosMotivos);
		console.log(arregloFechasEstimadas);
		console.log(arregloIds);

		if (arregloFechasEstimadas.length > 0
				&& arregloFechasReprogramadas.length > 0
				&& arregloIds.length > 0 && arreglosMotivos.length > 0
				&& arreglosMotivos.length == arregloFechasReprogramadas.length) {

			//Enviar arreglo
			$
					.ajax({
						type : 'POST',
						url : "guardarReprogramacionDeActividades",
						dataType : 'json',
						async : false,
						data : {
							fechasEstimadas : arregloFechasEstimadas,
							fechasRealesReprogramadas : arregloFechasReprogramadas,
							Ids : arregloIds,
							motivos : arreglosMotivos

						},
						success : function(data) {
							if (data == true) {
								toastr
										.success("Actividades reprogramadas correctamente");
								document.getElementById('divTablaActividades').style.display = 'none';
								$('#sector').val(-1);
								$("#predio").empty();
								$("#predio")
										.append(
												'<option value="-1">Seleccione un predio</option>');
								$('#motivo').val("");

								document.getElementById('divPlanAsignado').style.display = 'none';

							} else {
								toastr
										.error("Error al reprogramar las actividades");
							}
						},
						error : function(jqXHR, errorThrown) {
							alert("Error al guardar los datos");
						}
					});
		} else {
			toastr
					.error("Error, recuerde indicar fecha y motivo de reprogramación");
		}

	}
</script>



</html>