<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="template/libreria.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="template/cabecera.jsp"%>

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
			<section class="content"> <!-- Default box -->
			<h3>TEMPORADA 2018</h3>
			<div class="row">
				<div class="col-lg-3 col-xs-6">
					<!-- small box -->
					<div class="small-box bg-aqua">
						<div class="inner">
							<h4>Total Predios</h4>

							<p>${totalPredios}</p>
						</div>

					</div>
				</div>
				<!-- ./col -->
				<div class="col-lg-3 col-xs-6">
					<!-- small box -->
					<div class="small-box bg-green">
						<div class="inner">
							<h4>Predios En Proceso</h4>

							<p>${totalPrediosEnProceso}</p>
						</div>

					</div>
				</div>
				<!-- ./col -->
				<div class="col-lg-3 col-xs-6">
					<!-- small box -->
					<div class="small-box bg-yellow">
						<div class="inner">
							<h4>Predios Cosechados</h4>

							<p>${totalPrediosCosechados}</p>
						</div>

					</div>

				</div>
				<!-- ./col -->
				<div class="col-lg-3 col-xs-6">
					<!-- small box -->
					<div class="small-box bg-red">
						<div class="inner">
							<h4>Predios Sin Plan Asignado</h4>

							<p>${totalPrediosSinPlanAsignado}</p>
						</div>


					</div>
				</div>
				<!-- ./col -->
			</div>

			<div class="row">
				<div class="col-sm-6">
					<div class="box"
						style="background-color: #cee9f5; border-top: 3px solid #04c;">
						<div class="box-header with-border">
							<h3 class="box-title">
								<font style="vertical-align: inherit;"><font
									style="vertical-align: inherit;">ACTIVIDADES PR�XIMAS A
										REALIZAR</font></font>
							</h3>
							<br> <br>
							<div class="box-tools pull-right">
								<button type="button" class="btn btn-box-tool"
									data-widget="collapse" data-toggle="tooltip" title=""
									data-original-title="Minimizar">
									<i class="fa fa-minus"></i>
								</button>
								<button type="button" class="btn btn-box-tool"
									data-widget="remove" data-toggle="tooltip" title=""
									data-original-title="Eliminar">
									<i class="fa fa-times"></i>
								</button>
							</div>
						</div>
						<div class="box-body">


							<c:forEach var="listaActividades" items="${listaActividades}"
								varStatus="loop">
								<p>
									<c:set var="index" value="${loop.index}" />
									<c:set var="index" value="${index + 1}" />

									<c:out value="${index}"></c:out>
									. &nbsp;&nbsp;
									<c:out value="${listaActividades.actividad.nombre}"></c:out>
									&nbsp;&nbsp;- Fecha estimada :&nbsp;
									<fmt:formatDate value="${listaActividades.fechaEstimada}"
										pattern="dd-MM-yyyy" />
									&nbsp;&nbsp;- Sector : &nbsp;
									<c:out value="${listaActividades.predio.sector.nombre}"></c:out>
									&nbsp;&nbsp;- Predio :&nbsp;
									<c:out value="${listaActividades.predio.nombre}"></c:out>



								</p>

							</c:forEach>

						</div>
						<!-- /.box-body -->

						<!-- /.box-footer-->
					</div>
				</div>
				<div class="col-sm-6">
					<div class="box"
						style="background-color: #efceda; border-top: 3px solid #d01305;">
						<div class="box-header with-border">
							<h3 class="box-title">
								<font style="vertical-align: inherit;"><font
									style="vertical-align: inherit;">ACTIVIDADES ATRASADAS</font></font>
							</h3>
							<br> <br>
							<div class="box-tools pull-right">
								<button type="button" class="btn btn-box-tool"
									data-widget="collapse" data-toggle="tooltip" title=""
									data-original-title="Minimizar">
									<i class="fa fa-minus"></i>
								</button>
								<button type="button" class="btn btn-box-tool"
									data-widget="remove" data-toggle="tooltip" title=""
									data-original-title="Eliminar">
									<i class="fa fa-times"></i>
								</button>
							</div>
						</div>
						<div class="box-body">


							<c:forEach var="listaActividadesAtrasadas"
								items="${listaActividadesAtrasadas}" varStatus="loop">
								<p>
									<c:set var="index" value="${loop.index}" />
									<c:set var="index" value="${index + 1}" />

									<c:out value="${index}"></c:out>
									. &nbsp;&nbsp;
									<c:out value="${listaActividadesAtrasadas.actividad.nombre}"></c:out>
									&nbsp;&nbsp;- Fecha estimada :&nbsp;
									<fmt:formatDate
										value="${listaActividadesAtrasadas.fechaEstimada}"
										pattern="dd-MM-yyyy" />
									&nbsp;&nbsp;- Sector : &nbsp;
									<c:out
										value="${listaActividadesAtrasadas.predio.sector.nombre}"></c:out>
									&nbsp;&nbsp;- Predio :&nbsp;
									<c:out value="${listaActividadesAtrasadas.predio.nombre}"></c:out>



								</p>

							</c:forEach>

						</div>
					</div>
					<!-- /.box-body -->

					<!-- /.box-footer-->
				</div>
			</div>
			</section>

		</div>

		<!-- /.content-wrapper -->

		<footer align="center" class="main-footer"
			style="background-color:#ecf0f5;"> <%@ include
			file="template/pieDePagina.jsp"%> </footer>

		<div class="control-sidebar-bg"></div>

	</div>
	<%@ include file="template/scripts.jsp"%>
</body>


</html>