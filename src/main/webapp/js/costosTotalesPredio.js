function buscarSectores() {
	var idTemporada = $('#temporadaSeleccionada').val();

	if (idTemporada > 0) {
		document.getElementById('errorTemporada').style.display = 'none';
		document.getElementById('temporadaSeleccionada').style.border = "";
		document.getElementById('divTablaCostosPredios').style.display = 'none';
	} else {

		document.getElementById('errorTemporada').style.display = 'inline';
		document.getElementById('temporadaSeleccionada').style.border = "1px solid red";
		document.getElementById('divTablaCostosPredios').style.display = 'none';
		document.getElementById('divSector').style.display = 'none';
	}

	if (idTemporada > 0) {
		$
				.ajax({
					type : 'POST',
					url : "obtenerSectoresParaCostosPredios",
					dataType : 'json',
					data : {
						idTemporada : idTemporada
					},
					success : function(data) {
						console.log(data);
						if (!$.isEmptyObject(data)) {
							// cargar select

							$('#sectorSeleccionado').empty();
							$('#sectorSeleccionado')
									.append(
											'<option value="-1">Seleccione un sector</option>');

							for (var i = 0; i < data.length; i++) {
								console.log(data[i].idSector);
								$('#sectorSeleccionado').append(
										'<option value="' + data[i].idSector
												+ '">' + data[i].nombre
												+ '</option>');
							}

							// Mostrar select
							document.getElementById('divSector').style.display = 'inline';

						}

					},
					error : function(jqXHR, errorThrown) {
						alert("Error al obtener los sectores");
					}
				});
	}
}

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
		// document.getElementById('divTablaCostosPredios').style.display =
		// 'none';

	}

	if (idSector > 0 && idTemporada > 0) {

		document.getElementById('divTablaCostosPredios').style.display = 'inline';

		// Obtener los predios
		$
				.ajax({
					type : 'POST',
					url : "obtenerPrediosDelSectorYTemporadaSeleccionada",
					dataType : 'json',
					async : false,
					data : {
						idSector : idSector,
						idTemporada : idTemporada

					},
					success : function(data) {
						console.log(data);
						if (!$.isEmptyObject(data)) {

							document.getElementById('divTablaCostosPredios').style.display = 'inline';
							document.getElementById('sinPredio').style.display = 'none';
							document.getElementById('sectorSeleccionado').style.border = "";
							document.getElementById('errorSector').style.display = 'none';
							document.getElementById('sectorSeleccionado').style.border = "";

							// vaciar datatable
							var oTable = $('#tablaCostosPredios').dataTable();
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
											error : function(jqXHR, errorThrown) {
												alert("Error al obtener los costos");
											}
										});

							}
						} else {
							document.getElementById('divTablaCostosPredios').style.display = 'none';
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
		// document.getElementById('divTablaEstadoPredios').style.display =
		// 'none';
		document.getElementById('errorSector').style.display = 'inline';
		// document.getElementById('sector').style.border = "1px solid red";
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

							// vaciar datatable
							var oTable = $('#listaDetallesCostos').dataTable();
							oTable.fnClearTable();

							// Llenar data table
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
							// Mostrar modal
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
	separators = separators || [ '.', ".", ',' ];
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

$('#listaDetallesCostos').DataTable({

	"columnDefs" : [ {
		"targets" : 4,
		"className" : "text-right"
	}

	],
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
			"sPrevious" : "Anterior",

		}
	}

})