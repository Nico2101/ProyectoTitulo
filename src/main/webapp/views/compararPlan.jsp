<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="libreria.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="cabecera.jsp"%>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>

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
							<h3 class="box-title">Comparar Plan de Ejecución</h3>

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
													<th>Fecha Estimada Inicial</th>
													<th>Fecha Ejecución Real</th>
													<th>Reprogramaciones</th>
													<th>id actividad</th>

												</tr>
											</thead>

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

			</div>


			<!-- Modal ver reprogramaciones -->
			<div class="modal fade" id="modalVerReprogramaciones" tabindex="-1"
				role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-lg" role="document">
					<div class="modal-content">
						<div class="modal-header">

							<h4 class="modal-title" id="myModalLabel">Reprogramaciones
								de la Actividad</h4>
						</div>
						<div class="modal-body">


							<div class="row">

								<div class="box-body">

									<table id="tablaReprogramaciones"
										class="table table-striped table-bordered table-hover">

										<thead>
											<tr>

												<th width="40px">N°</th>
												<th>Nombre Actividad</th>
												<th width="170px">Fecha Estimada Anterior</th>
												<th width="170px">Fecha Reprogramación</th>
												<th>Motivo</th>

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
			document.getElementById('divTablaActividades').style.display = 'none';
			document.getElementById('divPlanAsignado').style.display = 'none';
			//Obtener los predios
			$
					.ajax({
						type : 'POST',
						url : "obtenerPrediosDelSectorConPlanAsignaParaComparacion",
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
			//document.getElementById('divTablaRegistrarActividadRealizada').style.display = 'none';
		}

	}

	function mostrarActividades() {

		document.getElementById('divPlanAsignado').style.display = 'none';
		document.getElementById('divTablaActividades').style.display = 'none';

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

		//obtener el id del predio
		var idPredio = $('#predio').val();
		if (idPredio > 0) {
			$
					.ajax({
						type : 'POST',
						url : "obtenerActividadesDelPlanAsignadoAlPredioVerificandoReprogramacion",
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

										// Add some text to the new cells:
										cell1.innerHTML = num;
										cell2.innerHTML = data[i].actividad.nombre;

										var fecha = moment(
												data[i].fechaEstimada,
												'YYYY/MM/DD');
										fecha = fecha.format('DD-MM-YYYY');
										cell3.innerHTML = fecha;

										if (data[i].fechaEjecucionReal == null) {
											cell4.innerHTML = "Actividad No Ejecutada";
										} else {
											fechaEjecucion = moment(
													data[i].fechaEjecucionReal,
													'YYYY/MM/DD');
											fechaEjecucion = fechaEjecucion
													.format('DD-MM-YYYY');
											cell4.innerHTML = fechaEjecucion;
										}

										var idAR = data[i].idActividadRealizada;

										//Preguntar si la actividad tiene reprogramaciones
										$
												.ajax({
													type : 'POST',
													url : "obtnerReprogramacionesActividad",
													dataType : 'json',
													async : false,
													data : {
														idActividadRealizada : data[i].idActividadRealizada
													},
													success : function(data) {
														console.log(data);
														if (data == true) {
															cell5.innerHTML = '<a href="#" title="Ver Reprogramaciones" onclick="verReprogramaciones('
																	+ idAR
																	+ ');"><i class="fa fa-eye fa-lg" style="color: blue"></i></a>';
														} else {
															cell5.innerHTML = "Sin Reprogramaciones";
														}
													},
													error : function(jqXHR,
															errorThrown) {
														alert("Error al obtener los productos");
													}
												});

										cell6.innerHTML = data[i].idActividadRealizada;

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

										if (j == 5)

											tbl.rows[i].cells[j].style.display = "none";

									}

								}
								document.getElementById('divPlanAsignado').style.display = 'inline';
								document.getElementById('divTablaActividades').style.display = 'inline';
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

	function verReprogramaciones(idActividadRealizada) {

		//Eliminar los datos
		var oTableIngre = document.getElementById('tablaReprogramaciones');

		//gets rows of table
		var rowLengthoTableIngre = oTableIngre.rows.length;

		for (t = 1; t < rowLengthoTableIngre; t++) {
			var Table = document.getElementById('tablaReprogramaciones');
			if (Table.rows.length > 0) {
				Table.deleteRow(1);

			}
		}

		//Obtener los datos
		$
				.ajax({
					type : 'POST',
					url : "obtenerDatosReprogramacionesActividad",
					dataType : 'json',
					data : {
						idActividadRealizada : idActividadRealizada
					},
					success : function(data) {
						console.log(data);
						if (!$.isEmptyObject(data)) {
							for (var i = 0; i < data.length; i++) {
								//N° Filas
								var filas = document
										.getElementById("tablaReprogramaciones").rows.length;
								console.log("filas: " + filas);

								if (filas >= 1) {
									//Agregar el nombre de la actividad a la tabla

									//numero
									var num = 0;
									var oTable = document
											.getElementById('tablaReprogramaciones');

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
											.getElementById("tablaReprogramaciones");

									// Create an empty <tr> element and add it to the 1st position of the table:
									var row = table.insertRow(filas);

									// Insert new cells (<td> elements) at the 1st and 2nd position of the "new" <tr> element:
									var cell1 = row.insertCell(0);
									var cell2 = row.insertCell(1);
									var cell3 = row.insertCell(2);
									var cell4 = row.insertCell(3);
									var cell5 = row.insertCell(4);

									// Add some text to the new cells:
									cell1.innerHTML = num;
									cell2.innerHTML = data[i].actividadRealizada.actividad.nombre;

									var fecha = moment(
											data[i].fechaEstimadaAnterior,
											'YYYY/MM/DD');
									fecha = fecha.format('DD-MM-YYYY');
									cell3.innerHTML = fecha;

									fechaReprogramacion = moment(
											data[i].fechaReprogramacion,
											'YYYY/MM/DD');
									fechaReprogramacion = fechaReprogramacion
											.format('DD-MM-YYYY');
									cell4.innerHTML = fechaReprogramacion;

									cell5.innerHTML = data[i].motivo;

								}
							}

							$('#modalVerReprogramaciones').modal('show');
						}
					},
					error : function(jqXHR, errorThrown) {
						alert("Error al obtener los datos");
					}
				});

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
</script>

</html>