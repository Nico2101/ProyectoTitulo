function mostrarEstadoPredios() {

	// obtener el id del predio
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

							document.getElementById('divTablaEstadoPredios').style.display = 'inline';
							document.getElementById('sinPredio').style.display = 'none';
							document.getElementById('sector').style.border = "";
							document.getElementById('errorSector').style.display = 'none';
							document.getElementById('sector').style.border = "";
							// vaciar datatable
							var oTable = $('#tablaEstadoPredios').dataTable();
							oTable.fnClearTable();

							// Llenar data table
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
												var planEjecucion = " Sin plan asignado";
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
											error : function(jqXHR, errorThrown) {
												alert("Error al obtener los predios del sector seleccionado");
											}
										});

							}
						} else {
							document.getElementById('divTablaEstadoPredios').style.display = 'none';
							document.getElementById('errorSector').style.display = 'none';
							document.getElementById('sector').style.border = "";
							document.getElementById('sinPredio').style.display = 'inline';
							document.getElementById('sector').style.border = "1px solid red";
						}

					},
					error : function(jqXHR, errorThrown) {
						alert("Error al obtener los predios con planes  ");
					}
				});

	} else {
		document.getElementById('divTablaEstadoPredios').style.display = 'none';
		document.getElementById('errorSector').style.display = 'inline';
		document.getElementById('sector').style.border = "1px solid red";
		document.getElementById('sinPredio').style.display = 'none';

	}
}

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