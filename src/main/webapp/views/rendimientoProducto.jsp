<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="template/libreria.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="template/cabecera.jsp"%>
<style>
.error {
	color: #FF0000;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>

</head>
<body class="skin-blue sidebar-mini">
	<div class="wrapper">

		<header class="main-header"> <%@ include
			file="template/barraSuperior.jsp"%> </header>
		<!-- Left side column. contains the logo and sidebar -->
		<aside class="main-sidebar"> <%@ include
			file="template/barraLateral.jsp"%> <!-- /.sidebar -->
		</aside>

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">


			<!-- Main content -->
			<section class="content"> <img id="imagen"
				src="images/loader2.gif" />

			<div class="row">
				<div class="col-xs-12">

					<div class="col-md-6 col-sm-6 col-xs-12">
						<h3 id="titulo" style="display: none">Informe Cosecha de
							Productos</h3>
					</div>
					<div class="col-md-3 col-sm-6 col-xs-12"></div>
					<div class="col-md-2 col-sm-6 col-xs-12"></div>
					<div id="botonGenerarReporte" style="display: none">

						<a id="#" href="generarReporteProductos">
							<button class="btn btn-primary pull-right" type="button">Generar
								Informe Resumen</button>

						</a>
					</div>

				</div>
				<br> <br> <br>
				<div id="graficos"></div>



			</div>

			</section>

			<!-- Modal Reporte Temporada -->
			<div class="modal fade" id="modalReporteTemporada" tabindex="-1"
				role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">

							<h4 class="modal-title" id="myModalLabel">Reporte Temporada</h4>

						</div>
						<div class="modal-body">


							<div id="form-editar" class="form-group">


								<label class="col-sm-4 control-label">* Temporada</label>
								<div class="col-sm-6">
									<select class="form-control" id="temporada">
									</select> <span id="errorTemporada" class="error" style="display: none">Debe
										seleccionar la temporada</span>
								</div>

								<br> <br> <br>

								<div align="center">
									<a id="generarReporteTemporada">

										<button class="btn btn-primary" type="button"
											id="botonGenerarInforme" onclick="generarReporte();">Generar
											Informe</button>
									</a>
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
						<br> <br>
						<div class="modal-footer">
							<button type="button" class="btn btn-danger pull-left"
								data-dismiss="modal">Cerrar</button>

						</div>
					</div>
				</div>
			</div>

		</div>

		<!-- /.content-wrapper -->

		<footer align="center" class="main-footer"
			style="background-color:#ecf0f5;"> <%@ include
			file="template/pieDePagina.jsp"%> </footer>

		<div class="control-sidebar-bg"></div>

	</div>
	<%@ include file="template/scripts.jsp"%>

</body>

<script src="js/rendimientoProducto.js">
	
</script>

</html>