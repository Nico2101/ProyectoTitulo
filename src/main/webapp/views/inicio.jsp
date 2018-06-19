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
			<section class="content"> <!-- Default box -->

			<div class="row">
				<div class="col-lg-3 col-xs-6">
					<!-- small box -->
					<div class="small-box bg-aqua">
						<div class="inner">
							<h4>Total Predios</h4>

							<p>20</p>
						</div>
						<div class="icon">
							<i class="ion ion-pie-graph"></i>
						</div>
					</div>
				</div>
				<!-- ./col -->
				<div class="col-lg-3 col-xs-6">
					<!-- small box -->
					<div class="small-box bg-green">
						<div class="inner">
							<h4>Predios Sembrados</h4>

							<p>10</p>
						</div>
						<div class="icon">
							<i class="ion ion-pie-graph"></i>
						</div>
					</div>
				</div>
				<!-- ./col -->
				<div class="col-lg-3 col-xs-6">
					<!-- small box -->
					<div class="small-box bg-yellow">
						<div class="inner">
							<h4>Predios Cosechados</h4>

							<p>6</p>
						</div>
						<div class="icon">
							<i class="ion ion-pie-graph"></i>
						</div>
					</div>
				</div>
				<!-- ./col -->
				<div class="col-lg-3 col-xs-6">
					<!-- small box -->
					<div class="small-box bg-red">
						<div class="inner">
							<h4>Predios Sin Plan Asignado</h4>

							<p>4</p>
						</div>
						<div class="icon">
							<i class="ion ion-pie-graph"></i>
						</div>
	
					</div>
				</div>
				<!-- ./col -->
			</div>
			
			
			<div class="box"
				style="background-color: #cee9f5; border-top: 3px solid #04c;">
				<div class="box-header with-border">
					<h3 class="box-title">
						<font style="vertical-align: inherit;"><font
							style="vertical-align: inherit;">ACTIVIDADES PRÓXIMAS A
								REALIZAR</font></font>
					</h3>
					<br> <br>
					<div class="box-tools pull-right">
						<button type="button" class="btn btn-box-tool"
							data-widget="collapse" data-toggle="tooltip" title=""
							data-original-title="Collapse">
							<i class="fa fa-minus"></i>
						</button>
						<button type="button" class="btn btn-box-tool"
							data-widget="remove" data-toggle="tooltip" title=""
							data-original-title="Remove">
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
							&nbsp;&nbsp;-
							<c:out value="${listaActividades.actividad.nombre}"></c:out>
							&nbsp;&nbsp;- Fecha estimada :&nbsp;
							<c:out value="${listaActividades.fechaEstimada}"></c:out>
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


</html>