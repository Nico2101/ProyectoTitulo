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
					<h3>Análisis Reprogramaciones</h3>
					<div id="botonGenerarReporte" style="display: none"></div>
				</div>

			</div>
			<br>
			<br>
			<div class="row">
				<div class="col-md-6">
					<!-- DONUT CHART -->
					<div class="box box-primary">
						<div class="box-header with-border">
							<h3 class="box-title">Planes con actividades
								reprogramadas</h3>

							<div class="box-tools pull-right">
								<button type="button" class="btn btn-box-tool"
									data-widget="collapse">
									<i class="fa fa-minus"></i>
								</button>
								<button type="button" class="btn btn-box-tool"
									data-widget="remove">
									<i class="fa fa-times"></i>
								</button>
							</div>
						</div>
						<div class="box-body">
							<canvas id="pieChartPlanes" style="height: 221px; width: 443px;"
								width="553" height="276"></canvas>
						</div>
						<!-- /.box-body -->
					</div>
				</div>
				<div class="col-md-6">
					<!-- DONUT CHART -->
					<div class="box box-primary">
						<div class="box-header with-border">
							<h3 class="box-title">10 Actividades más reprogramadas</h3>

							<div class="box-tools pull-right">
								<button type="button" class="btn btn-box-tool"
									data-widget="collapse">
									<i class="fa fa-minus"></i>
								</button>
								<button type="button" class="btn btn-box-tool"
									data-widget="remove">
									<i class="fa fa-times"></i>
								</button>
							</div>
						</div>
						<div class="box-body">
							<canvas id="pieChartActividades"
								style="height: 221px; width: 443px;" width="553" height="276"></canvas>
						</div>
						<!-- /.box-body -->
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
	//Obtener datos planes
	$
			.ajax({
				type : 'POST',
				url : "resumenPlanesMasReprogramados",
				dataType : 'json',
				success : function(data) {
					console.log(data);

					//Crear grafico

					//Donut chart

					var arregloColores = Array();
					var arregloLabel = Array();
					var arregloDataSets = Array();
					for (var i = 0; i < data.length; i++) {
						//Codigo para generar los colores random
						var color = 'rgb(' + (Math.floor(Math.random() * 256))
								+ ',' + (Math.floor(Math.random() * 256)) + ','
								+ (Math.floor(Math.random() * 256)) + ')';

						var nombre = data[i].nombrePlan;

						var dataS = data[i].total;

						//Guardar en los arreglos
						arregloColores.push(color);
						arregloLabel.push(nombre);
						arregloDataSets.push(dataS);

					}

					var myDonut = new Chart(
							document.getElementById("pieChartPlanes"),
							{
								type : 'pie',
								data : {
									labels : arregloLabel,
									datasets : [ {
										label : "Total Actividad Reprogramadas",
										backgroundColor : arregloColores,
										data : arregloDataSets
									} ]
								},
								options : {
									title : {
										display : true,
										text : ''//Titulo del grafico
									},
									tooltips : {
										mode : 'index',
										intersect : false,
										callbacks : {
											label : function(tooltipItem, datos) {

												return datos.labels[tooltipItem.index]
														+ " : "
														+ datos.datasets[tooltipItem.datasetIndex].data[tooltipItem.index]
														+ " reprogramaciones";
											}

										}
									}
								}
							});

				},
				error : function(jqXHR, errorThrown) {
					alert("Error al obtener los datos");
				}
			});

	//Obtener datos planes
	$
			.ajax({
				type : 'POST',
				url : "getTotalActividadesReprogramadas",
				dataType : 'json',
				success : function(data) {
					console.log(data);

					//Crear grafico

					//Donut chart

					var arregloColores = Array();
					var arregloLabel = Array();
					var arregloDataSets = Array();
					for (var i = 0; i < data.length; i++) {
						//Codigo para generar los colores random
						var color = 'rgb(' + (Math.floor(Math.random() * 256))
								+ ',' + (Math.floor(Math.random() * 256)) + ','
								+ (Math.floor(Math.random() * 256)) + ')';

						var nombre = data[i].nombreActividad + " - "
								+ data[i].nombrePlan;

						var dataS = data[i].total;

						//Guardar en los arreglos
						arregloColores.push(color);
						arregloLabel.push(nombre);
						arregloDataSets.push(dataS);

					}

					var myDonut = new Chart(
							document.getElementById("pieChartActividades"),
							{
								type : 'pie',
								data : {
									labels : arregloLabel,
									datasets : [ {
										label : "Total Actividad Reprogramadas",
										backgroundColor : arregloColores,
										data : arregloDataSets
									} ]
								},
								options : {
									title : {
										display : true,
										text : ''//Titulo del grafico
									},
									tooltips : {
										mode : 'index',
										intersect : false,
										callbacks : {
											label : function(tooltipItem, datos) {

												return datos.labels[tooltipItem.index]
														+ " : Total Reprogramaciones: "
														+ datos.datasets[tooltipItem.datasetIndex].data[tooltipItem.index];
											}

										}
									}
								}
							});

				},
				error : function(jqXHR, errorThrown) {
					alert("Error al obtener los datos");
				}
			});
</script>

</html>