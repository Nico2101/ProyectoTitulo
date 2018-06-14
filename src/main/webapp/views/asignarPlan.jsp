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
							<h3 class="box-title">Asignar Plan a Predio</h3>

							<label class="pull-right" style="font-weight: normal; color: red">*
								Campos obligatorios</label>

						</div>
						<!-- /.box-header -->
						<div class="box-body">
							<div id="filtros" class="row">
								<div class="form-group">

									<div class="col-md-3 col-sm-6 col-xs-12">
										<label>* Sector</label><select class="form-control"
											id="sectorSeleccionado" onchange="PrediosDeunSector()">
											<option value="-1">Seleccione sector</option>
											<c:forEach items="${sectores}" var="sectores">
												<option value="${sectores.idSector}"><c:out
														value="${sectores.nombre}" /></option>

											</c:forEach>

										</select> <span id="errorSector" class="error" style="display: none">Debe
											seleccionar un sector</span> <span id="sinPredio" class="error"
											style="display: none">Sector no tiene predios disponibles</span>
									</div>






									<div class="col-md-3 col-sm-6 col-xs-12">
										<label>* Predio</label><select class="form-control"
											id="predioSeleccionado">
											<option value="-1">Seleccione un predio</option>


										</select> <span id="errorPredio" class="error" style="display: none">Debe
											seleccionar un predio</span>
									</div>

									<div class="col-md-3 col-sm-6 col-xs-12">
										<label>* Temporada</label><select class="form-control"
											id="temporadaSeleccionada" onchange="mostrarPlanes();">
											<option value="-1">Seleccione temporada</option>
											<c:forEach items="${listaTemporadasActivas}"
												var="listaTemporadasActivas">
												<option value="${listaTemporadasActivas.idTemporada}"><c:out
														value="${listaTemporadasActivas.nombre}" /></option>

											</c:forEach>

										</select> <span id="errorTemporada" class="error" style="display: none">Debe
											seleccionar una temporada</span>
									</div>

									<div class="col-md-3 col-sm-4 col-xs-12" id="divPlanes"
										style="display: none">
										<label>* Plan</label><select class="form-control"
											id="planSeleccionado" onchange="actividadesDeUnPlan()">
											<option value="-1">Seleccione un plan</option>
											<c:forEach items="${listaPlanes}" var="listaPlanes">
												<option value="${listaPlanes.idPlanEjecucion}"><c:out
														value="${listaPlanes.nombre}" /></option>

											</c:forEach>

										</select> <span id="errorPlan" class="error" style="display: none">Debe
											seleccionar un plan</span>
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
			<div id="divTablaActividades" style="display: none">
				<div class="row">
					<div class="col-xs-12">
						<div class="box box-primary">

							<!-- /.box-header -->
							<div class="box-body">
								<h4 class="box-title">
									<center>
										<strong>Actividades del plan</strong>
									</center>
								</h4>
								<div class="row">
									<div class="col-sm-2" style="text-align: center;"></div>

									<div class="col-sm-7">
										<table id="tablaActividades"
											class="table table-striped table-bordered table-hover">

											<thead>
												<tr>

													<th width="50px">N°</th>
													<th width="260px">Nombre Actividad</th>
													<th width="200px">Fecha estimada de realización</th>
													<th><center>Id</center></th>


												</tr>
											</thead>
											<tbody id="contenido">

											</tbody>
										</table>

									</div>
									<div class="col-sm-3"></div>

								</div>
								<br>

								<div id="loader" class="pull-right" style="display: none">
									<img id="imagen" src="images/loaderWhite.gif" height="30" width="30"/>
								</div>

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
	function PrediosDeunSector() {
		var idSector = $("#sectorSeleccionado").val();

		console.log(idSector);

		if (idSector > 0) {

			$
					.ajax({
						type : 'POST',
						url : "obtenerPrediosDeUnSector",
						dataType : 'json',
						data : {
							idSector : idSector
						},
						success : function(data) {

							if (!$.isEmptyObject(data)) {
								document.getElementById('sectorSeleccionado').style.border = "";
								document.getElementById('sinPredio').style.display = 'none';

								//Vaciar select
								$("#predioSeleccionado").empty();
								$("#predioSeleccionado")
										.append(
												'<option value="-1">Seleccione un predio</option>');
								for (var i = 0; i < data.length; i++) {
									$("#predioSeleccionado").append(
											'<option value='+data[i].idPredio+'>'
													+ data[i].nombre
													+ '</option>');

								}
							} else {
								document.getElementById('sectorSeleccionado').style.border = "1px solid red";
								document.getElementById('sinPredio').style.display = 'inline';
								$("#predioSeleccionado").empty();
								$("#predioSeleccionado")
										.append(
												'<option value="-1">Seleccione un predio</option>');
							}

						},
						error : function(jqXHR, errorThrown) {
							toastr.error("Error");
						}
					});

		}
		document.getElementById('sinPredio').style.display = 'none';

	}

	function mostrarPlanes() {
		var idTemporada = $("#temporadaSeleccionada").val();

		console.log(idTemporada);

		if (idTemporada > 0) {
			document.getElementById('divPlanes').style.display = 'inline';

		} else {
			document.getElementById('divPlanes').style.display = 'none';
		}

	}

	function actividadesDeUnPlan() {
		var idPlan = $("#planSeleccionado").val();
		var idTemporada = $("#temporadaSeleccionada").val();
		var fechaInicio;
		var fechaFinal;

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

		console.log(idPlan);

		if (idPlan > 0) {

			$
					.ajax({
						type : 'POST',
						url : "obtenerFechasTemporada",
						dataType : 'json',
						data : {
							idTemporada : idTemporada
						},
						success : function(data) {
							console.log(data);
							if (!$.isEmptyObject(data)) {
								fechaInicio = data.fechaInicio;
								fechaTermino = data.fechaTermino;

								console.log(fechaInicio);

								$
										.ajax({
											type : 'POST',
											url : "obtenerListaActididadesPlan",
											dataType : 'json',
											data : {
												idPlan : idPlan
											},
											success : function(data) {
												console.log(data);
												if (!$.isEmptyObject(data)) {
													//Cargar los datos a la tabla
													for (var i = 0; i < data.length; i++) {
														//N° Filas
														var filas = document
																.getElementById("tablaActividades").rows.length;
														console.log("filas: "
																+ filas);

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
															var row = table
																	.insertRow(filas);

															var cell1 = row
																	.insertCell(0);
															var cell2 = row
																	.insertCell(1);
															var cell3 = row
																	.insertCell(2);
															var cell4 = row
																	.insertCell(3);
															cell1.innerHTML = num;
															cell2.innerHTML = data[i].nombre;
															var min = new Date();
															console.log(min);
															fechaMin = moment(
																	min,
																	'YYYY/MM/DD');
															fechaMin = fechaMin
																	.format('YYYY-MM-DD');

															console
																	.log(fechaMin);
															if (fechaInicio > fechaMin) {

																cell3.innerHTML = '<input type="date" id="fechaEstimada"  style="width:200px;height:30px;text-align: center" min="'+fechaInicio+'" max="'+fechaTermino+'" class="form-control select2 select2-hidden-accessible"/>';
															} else {
																cell3.innerHTML = '<input type="date" id="fechaEstimada"  style="width:200px;height:30px;text-align: center" min="'+fechaMin+'" max="'+fechaTermino+'" class="form-control select2 select2-hidden-accessible"/>';
															}
															cell4.innerHTML = data[i].idActividad;

														}

													}

													//Ocultar la columna id actividad
													var tbl = document
															.getElementById("tablaActividades");
													for (var i = 0; i < tbl.rows.length; i++) {

														for (var j = 0; j < tbl.rows[i].cells.length; j++) {

															tbl.rows[i].cells[j].style.display = "";

															if (j == 3)

																tbl.rows[i].cells[j].style.display = "none";

														}

													}
													document
															.getElementById('divTablaActividades').style.display = 'inline';

												}
											},
											error : function(jqXHR, errorThrown) {
												alert("Error al obtener las actividades");
											}
										});
							}

						},
						error : function(jqXHR, errorThrown) {
							alert("Error al obtener las actividades");
						}
					});

		} else {
			document.getElementById('divTablaActividades').style.display = 'none';
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

		var arregloFechas = Array();
		var arregloIds = Array();

		if (rowLength > 1) {
			//loops through rows    
			for (i = 1; i < rowLength; i++) {
				var oCells = oTable.rows.item(i).cells;//devuelve un objeto con la fila completa
				console.log(oCells[0].innerHTML);//Numero fila
				console.log(oCells[1].innerHTML);//Nombre Actividad
				console.log(oCells[2].innerHTML);//Fecha estimada
				console.log(oCells[3].innerHTML);//id actividad

				//var fecha = $('#fechaEstimada').val();
				//arregloFechas.push(oCells[2].value);
				arregloIds.push(oCells[3].innerHTML);//almacena los ids
				console.log(arregloIds);

			}
		}

		var filas = $("#tablaActividades").find("tr"); //devulve las filas del body de tu tabla segun el ejemplo que brindaste
		var fechas = "";
		for (i = 1; i < filas.length; i++) { //Recorre las filas 1 a 1
			var celdas = $(filas[i]).find("td"); //devolverá las celdas de una fila
			fechas = $($(celdas[2]).children("input")[0]).val();
			arregloFechas.push(fechas);

		}

		console.log(arregloFechas);

		//Obtener los datos del sector
		var sectorSeleccionado = $('#sectorSeleccionado').val();
		//Obtener los datos del predio
		var predioSeleccionado = $('#predioSeleccionado').val();

		//Obtener los datos de la temporada
		var temporadaSeleccionada = $('#temporadaSeleccionada').val();
		//Obtener los datos del plan
		var planSeleccionado = $('#planSeleccionado').val();
		var fechaEstimada = $('#fechaEstimada').val();

		if (sectorSeleccionado == -1) {
			document.getElementById('errorSector').style.display = 'inline';
			document.getElementById('sectorSeleccionado').style.border = "1px solid red";
		} else {
			document.getElementById('errorSector').style.display = 'none';
			document.getElementById('sectorSeleccionado').style.border = "";
		}

		if (predioSeleccionado < 0) {
			document.getElementById('errorPredio').style.display = 'inline';
			document.getElementById('predioSeleccionado').style.border = "1px solid red";
		} else {
			document.getElementById('errorPredio').style.display = 'none';
			document.getElementById('predioSeleccionado').style.border = "";
		}

		if (temporadaSeleccionada == -1) {
			document.getElementById('errorTemporada').style.display = 'inline';
			document.getElementById('temporadaSeleccionada').style.border = "1px solid red";
		} else {
			document.getElementById('errorTemporada').style.display = 'none';
			document.getElementById('temporadaSeleccionada').style.border = "";
		}

		if (planSeleccionado < 0) {
			document.getElementById('errorPlan').style.display = 'inline';
			document.getElementById('planSeleccionado').style.border = "1px solid red";
		} else {
			document.getElementById('errorPlan').style.display = 'none';
			document.getElementById('planSeleccionado').style.border = "";
		}

		if (sectorSeleccionado > 0 && predioSeleccionado > 0
				&& temporadaSeleccionada > 0 && planSeleccionado > 0
				&& arregloIds.length > 0 && arregloFechas.length > 0) {

			document.getElementById('loader').style.display = 'inline';

			//Enviar arreglo
			$
					.ajax({
						type : 'POST',
						url : "agregarPlanAPredio",
						dataType : 'json',
						data : {
							idPredio : predioSeleccionado,
							idTemporada : temporadaSeleccionada,
							actividadesFecha : arregloFechas,
							actividades : arregloIds

						},
						success : function(data) {
							if (data == true) {
								toastr.success("Asignación exitosa");
								document.getElementById('divTablaActividades').style.display = 'none';
								$('#sectorSeleccionado').val(-1);
								$("#predioSeleccionado").empty();
								$("#predioSeleccionado")
										.append(
												'<option value="-1">Seleccione un predio</option>');
								$('#temporadaSeleccionada').val(-1);
								$('#planSeleccionado').val(-1);
								//$('#predioSeleccionado').val("");
								document.getElementById('loader').style.display = 'none';

							} else {
								toastr
										.error("Error al registrar la actividad realizada");
							}
						},
						error : function(jqXHR, errorThrown) {
							toastr
									.error("Error al guardar los datos, verifique los datos ingresados");
						}
					});
		}

	}
</script>

</html>