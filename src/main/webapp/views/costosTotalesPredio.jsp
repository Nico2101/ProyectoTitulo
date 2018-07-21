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
							<h3 class="box-title">Costos totales por predio</h3>

							<label class="pull-right" style="font-weight: normal; color: red">*
								Campos obligatorios</label>

						</div>
						<!-- /.box-header -->
						<div class="box-body">
							<div id="filtros" class="row">
								<div class="form-group">

									<div class="col-md-3 col-sm-6 col-xs-12">
										<label>* Temporada</label> <select id="temporadaSeleccionada"
											class="form-control select2 select2-hidden-accessible"
											onchange="buscarPrediosDelSector();">

											<option value="-1">Seleccione una temporada</option>
											<c:forEach var="listaTemporadas" items="${listaTemporadas}">

												<option value="${listaTemporadas.idTemporada}">${listaTemporadas.nombre}</option>

											</c:forEach>


										</select> <span id="errorTemporada" class="error" style="display: none">Seleccione
											una temporada</span>
									</div>


									<div class="col-md-3 col-sm-6 col-xs-12">
										<label>* Sector</label><select class="form-control"
											id="sectorSeleccionado" onchange="buscarPrediosDelSector();">
											<option value="-1">Seleccione un sector</option>
											<c:forEach var="listaSectores" items="${listaSectores}">
												<option value="${listaSectores.idSector}">${listaSectores.nombre}</option>

											</c:forEach>

										</select> <span id="errorSector" class="error" style="display: none">Debe
											seleccionar un sector</span><span id="sinPredio" class="error"
											style="display: none">Sector no tiene predios con
											planes asignados en la temporada</span>
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

			<div id="divTablaCostosPredios" style="display: none">

				<div class="row">
					<div class="col-xs-12">
						<div class="box box-primary">
							<div class="box-header">
								<h3 class="box-title">Lista de costos</h3>

							</div>
							<!-- /.box-header -->
							<div class="box-body">
								<div class="row">
									<div class="col-sm-2" style="text-align: center;"></div>

									<div class="col-sm-7">
										<table id="tablaCostosPredios"
											class="table table-striped table-bordered table-hover">

											<thead>
												<tr>

													<th>N°</th>
													<th width="400px">Nombre Predio</th>
													<th width="250px">Costos totales</th>
													<th width="350px">Detalle</th>
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


			<!-- Modal Ver Detalle de costos -->
			<div class="modal fade" id="modalVerDetallesCostos" tabindex="-1"
				role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog  modal-lg" role="document">
					<div class="modal-content">
						<div class="modal-header">

							<h4 class="modal-title">Detalle de costos</h4>

						</div>
						<div class="modal-body">


							<div class="row">

								<div class="box-body">

									<table id="listaDetallesCostos"
										class="table table-striped table-bordered table-hover">

										<thead>
											<tr>
												<th width="25px">N°</th>
												<th>Nombre Insumo</th>
												<th>Tipo</th>
												<th>Unidad </th>
												<th>Costo Total</th>
												
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
	function buscarPrediosDelSector() {

		var idTemporada = $('#temporadaSeleccionada').val();
		var idSector = $('#sectorSeleccionado').val();
		console.log(idSector);
		console.log(idTemporada);

		if (idTemporada > 0) {
			document.getElementById('errorTemporada').style.display = 'none';
			document.getElementById('temporadaSeleccionada').style.border = "";
			document.getElementById('divTablaCostosPredios').style.display = 'none';
		} else {
			document.getElementById('errorTemporada').style.display = 'inline';
			document.getElementById('temporadaSeleccionada').style.border = "1px solid red";
			document.getElementById('divTablaCostosPredios').style.display = 'none';
		}

		if (idSector > 0) {
			document.getElementById('errorSector').style.display = 'none';
			document.getElementById('sectorSeleccionado').style.border = "";
		} else {
			if (idSector == -1) {
				document.getElementById('errorSector').style.display = 'inline';
				document.getElementById('sectorSeleccionado').style.border = "1px solid red";
				document.getElementById('sinPredio').style.display = 'none';
			} else {
				document.getElementById('sinPredio').style.display = 'inline';
				document.getElementById('sectorSeleccionado').style.border = "1px solid red";
				document.getElementById('errorSector').style.display = 'none';
			}
			//document.getElementById('divTablaCostosPredios').style.display = 'none';

		}

		if (idSector > 0 && idTemporada > 0) {

			document.getElementById('divTablaCostosPredios').style.display = 'inline';

			//Obtener los predios
			$
					.ajax({
						type : 'POST',
						url : "obtenerPrediosDelSectorConPlanAsignado",
						dataType : 'json',
						async : false,
						data : {
							idSector : idSector,
							idTemporada : idTemporada

						},
						success : function(data) {
							console.log(data);
							if (!$.isEmptyObject(data)) {

								document
										.getElementById('divTablaCostosPredios').style.display = 'inline';
								document.getElementById('sinPredio').style.display = 'none';
								document.getElementById('sectorSeleccionado').style.border = "";
								document.getElementById('errorSector').style.display = 'none';
								document.getElementById('sectorSeleccionado').style.border = "";

								//vaciar datatable
								var oTable = $('#tablaCostosPredios')
										.dataTable();
								oTable.fnClearTable();

								for (var i = 0; i < data.length; i++) {
									var idPredio = data[i].idPredio;

									$
											.ajax({
												type : 'POST',
												url : "costosPorPredio",
												dataType : 'json',
												async : false,
												data : {
													idPredio : idPredio,
													idTemporada : idTemporada
												},
												success : function(dato) {
													console.log(dato);

													if (dato > 0) {

														$('#tablaCostosPredios')
																.dataTable()
																.fnAddData(

																		[
																				i + 1,
																				data[i].nombre,
																				"$  "
																						+ currency(
																								dato,
																								1),

																				'<a href="#" title="Ver" onclick="verDetallesCostos('
																						+ data[i].idPredio
																						+ ','
																						+ idTemporada

																						+ ');"><i class="fa fa-eye fa-lg" style="color: blue"></i></a>' ]

																);

													} else {
														var costo = "0";
														var detalles = "No existen costos asociados al predio"
														$('#tablaCostosPredios')
																.dataTable()
																.fnAddData(

																		[
																				i + 1,
																				data[i].nombre,
																				costo,
																				detalles ]

																);

													}

												},
												error : function(jqXHR,
														errorThrown) {
													alert("Error al obtener los costos");
												}
											});

								}
							} else {
								document
										.getElementById('divTablaCostosPredios').style.display = 'none';
								document.getElementById('errorSector').style.display = 'none';
								document.getElementById('sectorSeleccionado').style.border = "";
								document.getElementById('sinPredio').style.display = 'inline';
								document.getElementById('sectorSeleccionado').style.border = "1px solid red";
							}

						},
						error : function(jqXHR, errorThrown) {
							alert("Error al obtener los predios con planes  ");
						}
					});

		} else {
			//document.getElementById('divTablaEstadoPredios').style.display = 'none';
			document.getElementById('errorSector').style.display = 'inline';
			//document.getElementById('sector').style.border = "1px solid red";
			document.getElementById('sinPredio').style.display = 'none';

		}
	}

	function verDetallesCostos(idPredio, idTemporada) {
		if (idPredio > 0 && idTemporada > 0) {

			$
					.ajax({
						type : 'POST',
						url : "obtenerDetalles",
						dataType : 'json',

						data : {
							idPredio : idPredio,
							idTemporada : idTemporada

						},

						success : function(data) {
							console.log(idPredio);
							console.log(idTemporada);
							console.log(data);

							if (!$.isEmptyObject(data)) {
								
								//vaciar datatable
								var oTable = $('#listaDetallesCostos')
										.dataTable();
								oTable.fnClearTable();

								//Llenar data table
								for (var i = 0; i < data.length; i++) {
									$('#listaDetallesCostos')
											.dataTable()
											.fnAddData(

													[
															i + 1,
															data[i].nombre,
															data[i].tipo,
															data[i].unidadDeMedida,

															"$  "
																	+ currency(
																			data[i].costosInsumo,
																			1), ]

											);
								}
								//Mostrar modal
								$('#modalVerDetallesCostos').modal('show');

							}

						},
						error : function(jqXHR, errorThrown) {
							alert("Error al obtener los productos");
						}
					});
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
</script>

<script>
	$('#tablaCostosPredios').DataTable({
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


<script>
	$('#listaDetallesCostos').DataTable({
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