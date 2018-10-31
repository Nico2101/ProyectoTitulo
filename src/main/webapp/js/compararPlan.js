function buscarPrediosSector() {
	var idTemporada = $('#temporada').val();
	var idSector = $('#sector').val();
	console.log(idSector);

	if (idTemporada > 0) {
		document.getElementById('errorTemporada').style.display = 'none';
		document.getElementById('temporada').style.border = "";
		document.getElementById('divPlanAsignado').style.display = 'none';
		document.getElementById('divTablaActividades').style.display = 'none';
		document.getElementById('divPredio').style.display = 'none';
	} else {
		document.getElementById('errorTemporada').style.display = 'inline';
		document.getElementById('temporada').style.border = "1px solid red";
		document.getElementById('divPlanAsignado').style.display = 'none';
		document.getElementById('divTablaActividades').style.display = 'none';
		document.getElementById('divPredio').style.display = 'none';
	}

	if (idSector > 0) {
		document.getElementById('errorSector').style.display = 'none';
		document.getElementById('sector').style.border = "";
	} else {
		if (idSector == -1) {
			document.getElementById('errorSector').style.display = 'inline';
			document.getElementById('sector').style.border = "1px solid red";
			document.getElementById('sinPredio').style.display = 'none';
		} else {
			document.getElementById('sinPredio').style.display = 'inline';
			document.getElementById('sector').style.border = "1px solid red";
			document.getElementById('errorSector').style.display = 'none';
		}
		document.getElementById('divPlanAsignado').style.display = 'none';
		document.getElementById('divTablaActividades').style.display = 'none';
		document.getElementById('divPredio').style.display = 'none';

	}

	if (idSector > 0 && idTemporada > 0) {

		document.getElementById('divTablaActividades').style.display = 'none';
		document.getElementById('divPlanAsignado').style.display = 'none';
		// Obtener los predios
		$
				.ajax({
					type : 'POST',
					url : "obtenerPrediosDelSectorConPlanAsignaParaComparacion",
					dataType : 'json',
					data : {
						idSector : idSector,
						idTemporada : idTemporada
					},
					success : function(data) {

						if (!$.isEmptyObject(data)) {
							document.getElementById('errorSector').style.display = 'none';
							document.getElementById('sector').style.border = "";
							document.getElementById('sinPredio').style.display = 'none';
							// Contruir el proximo select predio
							// Vaciar select
							$("#predio").empty();
							$("#predio")
									.append(
											'<option value="-1">Seleccione un predio</option>');
							for (var i = 0; i < data.length; i++) {
								$("#predio").append(
										'<option value=' + data[i].idPredio
												+ '>' + data[i].nombre
												+ '</option>');

							}

							document.getElementById('divPredio').style.display = 'inline';

						} else {

							document.getElementById('sector').style.border = "1px solid red";
							document.getElementById('sinPredio').style.display = 'inline';
							document.getElementById('divPlanAsignado').style.display = 'none';
							document.getElementById('divTablaActividades').style.display = 'none';
							document.getElementById('divPredio').style.display = 'none';
						}
					},
					error : function(jqXHR, errorThrown) {
						alert("Error al obtener los predios");
					}
				});

	}

}

function mostrarActividades() {

	document.getElementById('divPlanAsignado').style.display = 'none';
	document.getElementById('divTablaActividades').style.display = 'none';

	// Vaciar tabla
	var oTableIngre = document.getElementById('tablaActividades');

	// gets rows of table
	var rowLengthoTableIngre = oTableIngre.rows.length;

	for (t = 1; t < rowLengthoTableIngre; t++) {
		var Table = document.getElementById('tablaActividades');
		if (Table.rows.length > 0) {
			Table.deleteRow(1);

		}
	}

	// obtener el id del predio
	var idPredio = $('#predio').val();
	var idTemporada = $('#temporada').val();
	if (idPredio > 0 && idTemporada > 0) {
		document.getElementById('loader').style.display = 'inline';
		document.getElementById('errorPredio').style.display = 'none';
		document.getElementById('predio').style.border = "";
		$
				.ajax({
					type : 'POST',
					url : "obtenerActividadesDelPlanAsignadoAlPredioVerificandoReprogramacion",
					dataType : 'json',
					data : {
						idPredio : idPredio,
						idTemporada : idTemporada
					},
					success : function(data) {
						console.log(data);
						if (!$.isEmptyObject(data)) {
							// Cargar los datos a la tabla
							for (var i = 0; i < data.length; i++) {
								// N° Filas
								var filas = document
										.getElementById("tablaActividades").rows.length;
								console.log("filas: " + filas);

								if (filas >= 1) {
									// Agregar el nombre de la actividad a
									// la tabla

									// numero
									var num = 0;
									var oTable = document
											.getElementById('tablaActividades');

									var rowLength = oTable.rows.length;
									var oCells = oTable.rows
											.item(rowLength - 1).cells;
									var n = oCells[0].textContent;

									if (n == "N°") {
										num = 1;
									} else {
										num = parseInt(n) + 1;
									}

									// Find a <table> element with
									// id="myTable":
									var table = document
											.getElementById("tablaActividades");

									// Create an empty <tr> element and add
									// it to the 1st position of the table:
									var row = table.insertRow(filas);

									// Insert new cells (<td> elements) at
									// the 1st and 2nd position of the "new"
									// <tr> element:
									var cell1 = row.insertCell(0);
									var cell2 = row.insertCell(1);
									var cell3 = row.insertCell(2);
									var cell4 = row.insertCell(3);
									var cell5 = row.insertCell(4);
									var cell6 = row.insertCell(5);
									var cell7 = row.insertCell(6);

									// Add some text to the new cells:
									cell1.innerHTML = num;
									cell2.innerHTML = data[i].actividad.nombre;

									var fecha = moment(data[i].fechaEstimada,
											'YYYY/MM/DD');
									fecha = fecha.format('DD-MM-YYYY');
									cell3.innerHTML = fecha;

									var fechaActual = new Date();
									fechaActual = moment(fechaActual,
											'YYYY/MM/DD');
									fechaActual = fechaActual
											.format('DD-MM-YYYY');

									var idAR = data[i].idActividadRealizada;
									var tieneRepro = false;
									// Preguntar si la actividad tiene
									// reprogramaciones
									$
											.ajax({
												type : 'POST',
												url : "obtnerReprogramacionesActividad",
												dataType : 'json',
												async : false,
												data : {
													idActividadRealizada : data[i].idActividadRealizada
												},
												success : function(data) {
													console.log(data);
													if (data == true) {
														cell5.innerHTML = '<a href="#" title="Ver Reprogramaciones" onclick="verReprogramaciones('
																+ idAR
																+ ');"><i class="fa fa-eye fa-lg" style="color: blue"></i></a>';
														tieneRepro = true;
													} else {
														cell5.innerHTML = "";
													}
												},
												error : function(jqXHR,
														errorThrown) {
													alert("Error al obtener las reprogramaciones");
												}
											});

									if (data[i].fechaEjecucionReal == null) {
										console.log(fecha);
										console.log(fechaActual);
										if (process(fechaActual) > process(fecha)) {

											cell4.innerHTML = 'Actividad No Realizada'
													+ '<span class="pull-right-container"> <small class="label pull-right bg-red">Retrasada</small> </span>';
										} else {
											cell4.innerHTML = "Actividad No Realizada";
										}

									} else {
										fechaEjecucion = moment(
												data[i].fechaEjecucionReal,
												'YYYY/MM/DD');
										fechaEjecucion = fechaEjecucion
												.format('DD-MM-YYYY');
										if (tieneRepro == true) {
											cell4.innerHTML = fechaEjecucion
													+ '<span class="pull-right-container"> <small class="label pull-right bg-purple">Realizada/Reprogramada</small> </span>';
										} else {
											if (process(fechaEjecucion) > process(fecha)) {
												cell4.innerHTML = fechaEjecucion
														+ '<span class="pull-right-container"> <small class="label pull-right bg-orange">Realizada con retraso</small> </span>';
											} else {

												if (fechaEjecucion == fecha) {

													cell4.innerHTML = fechaEjecucion
															+ '<span class="pull-right-container"> <small class="label pull-right bg-green">Realizada en fecha estimada</small> </span>';
												} else {
													cell4.innerHTML = fechaEjecucion
															+ '<span class="pull-right-container"> <small class="label pull-right bg-teal">Realizada con anticipación</small> </span>';
												}

											}
										}

									}

									// Preguntar si la actividad tiene
									// costos
									$
											.ajax({
												type : 'POST',
												url : "verificarSiLaActividadTieneCostos",
												dataType : 'json',
												async : false,
												data : {
													idActividadRealizada : data[i].idActividadRealizada
												},
												success : function(data) {
													console.log(data);
													if (data == true) {
														cell7.innerHTML = '<a href="#" title="Ver Insumos" onclick="verInsumosActividadRealizada('
																+ idAR
																+ ');"><i class="fa fa-eye fa-lg" style="color: blue"></i></a>';
													} else {
														cell7.innerHTML = "";
													}

												},
												error : function(jqXHR,
														errorThrown) {
													alert("Error al obtener los costos de la actividad");
												}
											});

									cell6.innerHTML = data[i].idActividadRealizada;

									$('#planAsignado')
											.val(
													data[i].actividad.planEjecucion.nombre);

								}

							}

							// Ocultar la columna id actividad
							var tbl = document
									.getElementById("tablaActividades");
							for (var i = 0; i < tbl.rows.length; i++) {

								for (var j = 0; j < tbl.rows[i].cells.length; j++) {

									tbl.rows[i].cells[j].style.display = "";

									if (j == 5)

										tbl.rows[i].cells[j].style.display = "none";

								}

							}
							document.getElementById('divPlanAsignado').style.display = 'inline';
							document.getElementById('divTablaActividades').style.display = 'inline';
							document.getElementById('loader').style.display = 'none';
						}
					},
					error : function(jqXHR, errorThrown) {
						alert("Error al obtener las actividades del plan asignado al predio seleccionado");
					}
				});
	} else {
		document.getElementById('divPlanAsignado').style.display = 'none';
		document.getElementById('divTablaActividades').style.display = 'none';
		document.getElementById('loader').style.display = 'none';
		document.getElementById('errorPredio').style.display = 'inline';
		document.getElementById('predio').style.border = "1px solid red";
	}
}

function verReprogramaciones(idActividadRealizada) {

	// Eliminar los datos
	var oTableIngre = document.getElementById('tablaReprogramaciones');

	// gets rows of table
	var rowLengthoTableIngre = oTableIngre.rows.length;

	for (t = 1; t < rowLengthoTableIngre; t++) {
		var Table = document.getElementById('tablaReprogramaciones');
		if (Table.rows.length > 0) {
			Table.deleteRow(1);

		}
	}

	// Obtener los datos
	$
			.ajax({
				type : 'POST',
				url : "obtenerDatosReprogramacionesActividad",
				dataType : 'json',
				data : {
					idActividadRealizada : idActividadRealizada
				},
				success : function(data) {
					console.log(data);
					if (!$.isEmptyObject(data)) {
						// vaciar datatable
						var oTable = $('#tablaReprogramaciones').dataTable();
						oTable.fnClearTable();

						// Llenar data table
						for (var i = 0; i < data.length; i++) {
							var fecha = moment(data[i].fechaEstimadaAnterior,
									'YYYY/MM/DD');
							fecha = fecha.format('DD-MM-YYYY');

							var fechaReprogramacion = moment(
									data[i].fechaReprogramacion, 'YYYY/MM/DD');
							fechaReprogramacion = fechaReprogramacion
									.format('DD-MM-YYYY');
							$('#tablaReprogramaciones')
									.dataTable()
									.fnAddData(

											[
													i + 1,
													data[i].actividadRealizada.actividad.nombre,
													fecha, fechaReprogramacion,

													data[i].motivo ]

									);

						}
						// Mostrar modal
						$('#modalVerReprogramaciones').modal('show');

					}
				},
				error : function(jqXHR, errorThrown) {
					alert("Error al obtener los datos");
				}
			});

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

function buscarSector() {
	// Obtener sector
	var idTemporada = $('#temporada').val();
	if (idTemporada > 0) {
		document.getElementById('errorTemporada').style.display = 'none';
		document.getElementById('temporada').style.border = "";
		document.getElementById('divPlanAsignado').style.display = 'none';
		document.getElementById('divTablaActividades').style.display = 'none';
		document.getElementById('divPredio').style.display = 'none';
		document.getElementById('divSector').style.display = 'none';

	} else {
		document.getElementById('errorTemporada').style.display = 'inline';
		document.getElementById('temporada').style.border = "1px solid red";
		document.getElementById('divPlanAsignado').style.display = 'none';
		document.getElementById('divTablaActividades').style.display = 'none';
		document.getElementById('divPredio').style.display = 'none';
		document.getElementById('divSector').style.display = 'none';
	}

	if (idTemporada > 0) {
		// Obtener los sectores que están ejecutando esa temporada
		$
				.ajax({
					type : 'POST',
					url : "getSectoresConPrediosConPlanes",
					dataType : 'json',
					data : {
						idTemporada : idTemporada
					},
					success : function(data) {
						console.log(data);
						if (!$.isEmptyObject(data)) {
							document.getElementById('errorTemporada2').style.display = 'none';
							document.getElementById('temporada').style.border = "";
							// Vaciar select sector y cargar los datos
							$('#sector').empty();
							$('#sector')
									.append(
											'<option value="-1">Seleccione un sector</option>');
							for (var i = 0; i < data.length; i++) {
								$('#sector').append(
										'<option value=' + data[i].idSector
												+ '>' + data[i].nombre
												+ '</option>');
							}

							// Mostrar sector
							document.getElementById('divSector').style.display = 'inline';
						} else {
							// Mostrar mensaje de error
							document.getElementById('errorTemporada2').style.display = 'inline';
							document.getElementById('temporada').style.border = "1px solid red";
						}

					},
					error : function(jqXHR, errorThrown) {
						alert("Error al obtener los sectores");
					}
				});

	}
}

function verInsumosActividadRealizada(idActividadRealizada) {
	if (idActividadRealizada > 0) {
		// Obtener los datos de los insumos utilizados
		$
				.ajax({
					type : 'POST',
					url : "obtenerInsumosUtilizadosEnLaActividad",
					dataType : 'json',
					data : {
						idActividad : idActividadRealizada
					},
					success : function(data) {
						console.log(data);
						if (!$.isEmptyObject(data)) {
							// Cargar los datos en el modal
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
														data[i].insumo.nombre,
														data[i].insumo.tipo,
														data[i].insumo.unidadMedida,
														data[i].cantidad,
														"$  "
																+ currency(
																		data[i].costo,
																		1), ]

										);
							}
							// Mostrar modal
							$('#modalVerDetallesCostos').modal('show');

						}

					},
					error : function(jqXHR, errorThrown) {
						alert("Error al obtener los insumos utilizados en la actividad");
					}
				});
	}
}

function process(date) {
	var parts = date.split("-");
	return new Date(parts[2], parts[1] - 1, parts[0]);
}

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

$('#tablaReprogramaciones').DataTable({
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