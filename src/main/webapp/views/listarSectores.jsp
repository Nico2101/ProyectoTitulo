<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
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
							<h3 class="box-title">Lista de Sectores</h3>
							
							<button class="btn btn-primary pull-right" data-toggle="modal" data-target="#modalSector">Agregar Sector</button>
							
						</div>
                              <!-- Modal -->
                                <p></p>
                                <div class="modal fade" id="modalSector" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                    <div class="modal-dialog" role="document">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h2 class="modal-title" id="modalSector">Datos Sector</h2>
                                               
                                            </div>
                                            <div class="modal-body">
                                                <form class="form-horizontal" name="form1" action="#" method =post>
                                                    
                                                    <div class="form-group row">
                                                        <label for="nombre" class="col-lg-2 col-form-label">Nombre </label>
                                                        <div class="col-lg-8">
                                                            <input type="text" class="form-control"  name="nombre" placeholder="Nombre" required="">
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label for="apellido" class="col-lg-2 col-form-label">Superficie</label>
                                                        <div class="col-lg-8">
                                                            <input type="text" class="form-control"  name="superficie" placeholder="Superficie" required>
                                                        </div>
                                                    </div>
                                                  
                                                    <div class="modal-footer">
                                                <button type="button" class="btn btn-danger" data-dismiss="modal">Cerrar</button>
                                                <button type="submit" class="btn btn-raised btn-success">Guardar</button>
                                                </form>
                                            </div>
                                           
                                            </div>
                                        </div>
                                    </div>
                                </div>
						<div class="box-body">
							<div class="row">
								<div class="col-xs-12">
									<table id="totalsectores" class="table table-condensed">
										<thead>
											<tr>
												<th>Nº</th>
												<th>Nombre</th>
												<th>Superficie</th>

											</tr>
										</thead>
										<c:set var="i" value="0" />
										<c:forEach var="sector" items="${sectores}">
											<c:set var="i" value="${i+1}" />
											<tr>


												<td><c:out value="${i}"></c:out></td>
												<td><c:out value="${sector.nombre}"></c:out></td>
												<td><c:out value="${sector.superficie}"></c:out></td>

											</tr>
										</c:forEach>

									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			</section>




			<!-- Main content -->

		</div>

		<!-- /.content-wrapper -->

		<footer align="center" class="main-footer"
			style="background-color:#ecf0f5;"> <%@ include
			file="pieDePagina.jsp"%> </footer>
		<div class="control-sidebar-bg"></div>


	</div>
	<%@ include file="scripts.jsp"%>
</body>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script type="text/javascript"
	src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js">
	
</script>
<script
	src="https://cdn.datatables.net/1.10.16/js/dataTables.bootstrap.min.js"></script>

<script>
	$(function() {
		$('#totalsectores')
				.DataTable(
						{
							'paging' : true,
							'lengthChange' : false,
							'searching' : false,
							'ordering' : false,
							'info' : true,
							'autoWidth' : true,
							'responsive' : true,
							"language" : {
								"sProcessing" : "Procesando...",
								"sSearch" : "Buscar :",
								"sLengthMenu" : "Mostrar _MENU_ registros",
								"sZeroRecords" : "No se encontraron resultados",
								"sEmptyTable" : "Ningún dato disponible en esta tabla",
								"sInfo" : "Mostrando del _START_ al _END_ de _TOTAL_",
								"sInfoEmpty" : "Mostrando del 0 al 0 de 0",
								"sInfoFiltered" : "(filtrado de un total de _MAX_ registros)",
								"sInfoPostFix" : "",
								"sUrl" : "",
								"sInfoThousands" : ",",
								"sLoadingRecords" : "Cargando...",
								"oPaginate" : {
									"sFirst" : "Primero",
									"sLast" : "Último",
									"sNext" : "Siguiente",
									"sPrevious" : "Anterior"

								},
								"oAria" : {
									"sSortAscending" : ": Activar para ordenar la columna de manera ascendente",
									"sSortDescending" : ": Activar para ordenar la columna de manera descendente"
								}
							}
						})
	})
</script>

</html>