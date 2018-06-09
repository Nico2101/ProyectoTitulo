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
							<h3 class="box-title">Mostrar estado de los predios</h3>

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
											onchange="mostrarEstadoPredios();">

											<option value="-1">Seleccione un sector</option>
											<c:forEach var="listaSectores" items="${listaSectores}">

												<option value="${listaSectores.idSector}">${listaSectores.nombre}</option>

											</c:forEach>


										</select> <span id="errorSector" class="error" style="display: none">Seleccione
											un sector</span> <span id="sinPredio" class="error"
											style="display: none">Sector no tiene predios</span>
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

			<div id="divTablaEstadoPredios" style="display: none">

				<div class="row">
					<div class="col-xs-12">
						<div class="box box-primary">
							<div class="box-header">
								<h3 class="box-title">Lista de predios y sus estados</h3>

							</div>
							<!-- /.box-header -->
							<div class="box-body">
								<div class="row">
									<div class="col-sm-2" style="text-align: center;"></div>

									<div class="col-sm-7">
										<table id="tablaEstadoPredios"
											class="table table-striped table-bordered table-hover">

											<thead>
												<tr>

													<th>N°</th>
													<th width="400px">Nombre Predio</th>
													<th width="250px">Estado</th>
													<th width="250px">Plan Ejecución</th>
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
	function mostrarEstadoPredios() {

		//obtener el id del predio
		var idSector = $('#sector').val();
		if (idSector > 0) {

			$
					.ajax({
						type : 'POST',
						url : "obtenerEstadoDeLosPredios",
						dataType : 'json',
						async : false,
						data : {
							idSector : idSector
						},
						success : function(data) {
							console.log(data);
							if (!$.isEmptyObject(data)) {

								document
										.getElementById('divTablaEstadoPredios').style.display = 'inline';
								document.getElementById('sinPredio').style.display = 'none';
								document.getElementById('errorSector').style.display = 'none';
								//vaciar datatable
								var oTable = $('#tablaEstadoPredios')
										.dataTable();
								oTable.fnClearTable();

								//Llenar data table
								for (var i = 0; i < data.length; i++) {
									var idPredio = data[i].idPredio;

									

									$
											.ajax({
												type : 'POST',
												url : "obtenerActividadesDelPlanAsignadoAlPredio",
												dataType : 'json',
												async : false,
												data : {
													idPredio : idPredio
												},
												success : function(dato) {
													
													var estado = "Sin estado";
													var planEjecucion = " Sin plan asigando";
													if (!$.isEmptyObject(dato)) {

														$('#tablaEstadoPredios')
																.dataTable()
																.fnAddData(

																		[
																				i + 1,
																				data[i].nombre,
																				data[i].estado,
																				dato[i].actividad.planEjecucion.nombre ]

																);

													} else {

														$('#tablaEstadoPredios')
																.dataTable()
																.fnAddData(

																		[
																				i + 1,
																				data[i].nombre,
																				estado,
																				planEjecucion ]

																);

													}
												},
												error : function(jqXHR,
														errorThrown) {
													alert("Error al obtener los predios del sector seleccionado");
												}
											});

								}
							} else {
								document
										.getElementById('divTablaEstadoPredios').style.display = 'none';
								document.getElementById('errorSector').style.display = 'none';
								document.getElementById('sinPredio').style.display = 'inline';
							}

						},
						error : function(jqXHR, errorThrown) {
							alert("Error al obtener los predios con planes  ");
						}
					});

		} else {
			document.getElementById('divTablaEstadoPredios').style.display = 'none';
			document.getElementById('errorSector').style.display = 'inline';
			document.getElementById('sinPredio').style.display = 'none';
		}
	}
</script>

<script>
	$('#tablaEstadoPredios').DataTable({
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