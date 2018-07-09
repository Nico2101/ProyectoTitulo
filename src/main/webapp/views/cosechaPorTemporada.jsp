<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="libreria.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="cabecera.jsp"%>
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
			file="barraSuperior.jsp"%> </header>
		<!-- Left side column. contains the logo and sidebar -->
		<aside class="main-sidebar"> <%@ include
			file="barraLateral.jsp"%> <!-- /.sidebar -->
		</aside>

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">

			<!-- Main content -->
			<section class="content"> <!-- Default box -->


			<div class="row">
				<div class="col-xs-12">
					<div class="box box-primary">
						<div class="box-header">
							<h3 class="box-title">Informe Cosecha de Productos por Temporada</h3>

							<label class="pull-right" style="font-weight: normal; color: red">*
								Campos obligatorios</label>

						</div>
						<!-- /.box-header -->
						<div class="box-body">
							<div id="filtros" class="row">
								<div class="form-group">

									<div class="col-md-3 col-sm-6 col-xs-12">
										<label>* Temporada</label> <select id="temporada"
											class="form-control select2 select2-hidden-accessible">

											<option value="-1">Seleccione una temporada</option>
											<c:forEach var="listaTemporadas" items="${listaTemporadas}">

												<option value="${listaTemporadas.idTemporada}">${listaTemporadas.nombre}</option>

											</c:forEach>


										</select> <span id="errorTemporada" class="error" style="display: none">Seleccione
											una temporada</span> <span id="errorTemporada2" class="error"
											style="display: none">Temporada no ha sido ejecutada
											en ningún predio</span>
									</div>



									<div class="col-md-3 col-sm-6 col-xs-12">
										<label style="visibility: hidden">Boton</label> <a
											id="generarReporteTemporada"> <br>
											<button class="btn btn-primary" type="button"
												id="botonGenerarInforme" onclick="generarReporte();">Generar
												Informe Temporada</button>
										</a>
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
	function generarReporte() {
		//Obtener temporada
		var aux = false;
		var idTemporada = $('#temporada').val();
		if (idTemporada < 0) {
			document.getElementById('temporada').style.border = "1px solid red";
			document.getElementById('errorTemporada').style.display = 'inline';
		} else {
			document.getElementById('temporada').style.border = "";
			document.getElementById('errorTemporada').style.display = 'none';

		}

		if (idTemporada > 0) {
			$
					.ajax({
						type : 'POST',
						url : "verificarDatosReporteTemporadas",
						dataType : 'json',
						data : {
							idTemporada : idTemporada
						},
						success : function(data) {
							if (!$.isEmptyObject(data)) {
								location.href = "generarReporteTemporada?idTemporada="
										+ idTemporada;

							} else {

								toastr
										.error("No hay datos en la temporada seleccionada");
							}

						},
						error : function(jqXHR, errorThrown) {
							alert("Error al verificar la temporada");
						}
					});
		}

	}
</script>


</html>