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
							<h3 class="box-title">Asignar plan de ejecución a predio</h3>

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
											seleccionar un sector</span>
									</div>





									<div class="col-md-3 col-sm-6 col-xs-12">
										<label>* Predio</label><select class="form-control"
											id="predioSeleccionado">
											<option value="-1">Seleccione predio</option>


										</select> <span id="errorPredio" class="error" style="display: none">Debe
											seleccionar un predio</span>
									</div>

									<div class="col-md-3 col-sm-6 col-xs-12">
										<label>* Temporada</label><select class="form-control"
											id="temporadaSeleccionada">
											<option value="-1">Seleccione temporada</option>
											<c:forEach items="${listaTemporadasActivas}"
												var="listaTemporadasActivas">
												<option value="${listaTemporadasActivas.idTemporada}"><c:out
														value="${listaTemporadasActivas.nombre}" /></option>

											</c:forEach>

										</select> <span id="errorTemporada" class="error" style="display: none">Debe
											seleccionar una temporada</span>
									</div>

									<div class="col-md-3 col-sm-4 col-xs-12">
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
			<div class="row" id="mostrar" style="display: none">
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

												<th><center>N°</center></th>
												<th><center>Nombre Actividad</center></th>
												<th><center>Fecha estimada de realización</center></th>
												<th ><center>Id</center></th>


											</tr>
										</thead>
										<tbody id="contenido">

										</tbody>
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

							$('#predioSeleccionado').empty();

							$
									.each(
											data,
											function(key, predio) {
												$("#predioSeleccionado")
														.prepend(
																"<option value='-1'>Seleccione predio</option>");
												$("#predioSeleccionado")
														.append(
																'<option value='+predio.idPredio+'>'
																		+ predio.nombre
																		+ '</option>');
											});
						},
						error : function(jqXHR, errorThrown) {
							toastr.error("Error");
						}
					});

		}
	}

	function actividadesDeUnPlan() {
		var idPlan = $("#planSeleccionado").val();

		console.log(idPlan);

		if (idPlan > 0) {
			//habilita los input
			document.getElementById('mostrar').style.display = 'inline';
		} else {
			document.getElementById('mostrar').style.display = 'none';

		}

		if (idPlan > 0) {

			//Actualizar el data table
			$
					.ajax({
						type : 'POST',
						url : "obtenerListaActididadesPlan",
						dataType : 'json',
						data : {
							idPlan : idPlan
						},
						success : function(data) {
							$('#contenido').empty();

							var contador = 0;
							$
									.each(
											data,
											function(id, actividades) {
														contador++,
														$('#tablaActividades')
																.append(
																		'<tr><td>'
																				+ contador
																				+ '</td><td>'
																				+ actividades.nombre
																				+ '</td><td><center><input type="date" class="form-control" id="fechaEstimada" style="width:200px;height:30px;text-align: center"> </center></td><td >'
																				+ actividades.idActividad
																				+ '</td></tr>');
												console.log(contador + ' '
														+ actividades.nombre);
											});
						},
						error : function(jqXHR, errorThrown) {
							toastr.error("Error");
						}
					});

		}
	}

	function guardarDatos() {

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

		/*if (fechaEstimada == "") {
			document.getElementById('errorFechaEstimada').style.display = 'inline';
			document.getElementById('fechaEstimada').style.border = "1px solid red";
		} else {
			document.getElementById('errorFechaEstimada').style.display = 'none';
			document.getElementById('fechaEstimada').style.border = "";
		}  */

		var oTable = document.getElementById('tablaActividades');
		//obtiene filas de la tabla
		var rowLength = oTable.rows.length;

		if (sectorSeleccionado > 0 && predioSeleccionado > 0
				&& temporadaSeleccionada > 0 && planSeleccionado > 0) {

			var arregloActividades = new Array();

			//obteniene el id de las actividades de la tabla
			for (var i = 1; i < rowLength; i++) {
				var oCells = oTable.rows.item(i).cells;//devuelve un objeto con la fila completa
				arregloActividades.push(oCells[3].innerText);
			}

			console.log(arregloActividades);
			

			var arregloFechas =  new Array();

			//obtiene las fechas estimadas de las  actividades de la tabla
			for (var i = 1; i < rowLength; i++) {
				var fechas = document.getElementById("fechaEstimada").value;
				arregloFechas.push(fechas);
				
			}

			console.log(arregloFechas);

			$
					.ajax({
						type : 'POST',
						url : "agregarPlanAPredio",
						dataType : 'json',
						data : {
							idPredio : predioSeleccionado,
							idTemporada : temporadaSeleccionada,
							actividades : arregloActividades,
							actividadesFecha : arregloFechas

						},
						success : function(data) {
							console.log(data);
							if (data == true) {
								toastr
										.success("El plan ha sido agregado correctamente al predio");
								$('#sectorSeleccionado').val("");
								$('#predioSeleccionado').val("");
								$('#temporadaSeleccionada').val("");
								$('#planSeleccionado').val("");

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
										.error("Se ha producido un error al asignar un plan al predio");
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