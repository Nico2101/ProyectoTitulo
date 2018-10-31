function agregarTemporada() {

	// Verificar la cantidad maxima de temporadas activas
	// Pueden ser solo 4
	$
			.ajax({
				type : 'POST',
				url : "verificarCantidadTotalDeTemporadasActivas",
				dataType : 'json',
				success : function(data) {
					if (data < 4) {
						$('#modalAgregarTemporada').modal('show');

						// Limpiar modal
						$('#nombreTemporada').val("");
						$('#fechaInicio').val("");
						$("#fechaTermino").val("");

						document.getElementById('errorNombreTemporada').style.display = 'none';
						document.getElementById('nombreTemporada').style.border = "";

						document.getElementById('errorFechaInicio').style.display = 'none';
						document.getElementById('fechaInicio').style.border = "";

						document.getElementById('errorFechaTermino').style.display = 'none';
						document.getElementById('fechaTermino').style.border = "";

						document.getElementById('errorFechaTerminoMenor').style.display = 'none';
						document.getElementById('fechaTermino').style.border = "";
					} else {
						toastr
								.error("Error, Al agregar otra temporada excede el total permitido. Debe finalizar la temporada que corresponda");
					}
				},
				error : function(jqXHR, errorThrown) {
					alert("Error al verificar temporadas");
				}
			});

}

function guardarDatosTemporada() {
	// Obtener los datos
	var nombreTemporada = $('#nombreTemporada').val();
	var fechaInicio = $('#fechaInicio').val();
	var fechaTermino = $('#fechaTermino').val();

	console.log(nombreTemporada);
	console.log(fechaInicio);
	console.log(fechaTermino);

	// Validacion para el nombre
	if (nombreTemporada == "") {
		document.getElementById('errorNombreTemporada').style.display = 'inline';
		document.getElementById('nombreTemporada').style.border = "1px solid red";
	} else {
		document.getElementById('errorNombreTemporada').style.display = 'none';
		document.getElementById('nombreTemporada').style.border = "";
	}

	// Validacion para el tipo
	if (fechaInicio == "") {
		document.getElementById('errorFechaInicio').style.display = 'inline';
		document.getElementById('fechaInicio').style.border = "1px solid red";
	} else {
		document.getElementById('errorFechaInicio').style.display = 'none';
		document.getElementById('fechaInicio').style.border = "";
	}

	// Validacion para la unidad de medida
	if (fechaTermino == "") {
		document.getElementById('errorFechaTermino').style.display = 'inline';
		document.getElementById('fechaTermino').style.border = "1px solid red";
	} else {
		document.getElementById('errorFechaTermino').style.display = 'none';
		document.getElementById('fechaTermino').style.border = "";
	}

	if (nombreTemporada != "" && fechaInicio != "" && fechaTermino != "") {

		// Validar que la fecha de inicio sea menor a la fecha de termino
		if (fechaTermino < fechaInicio) {
			document.getElementById('errorFechaTerminoMenor').style.display = 'inline';
			document.getElementById('fechaTermino').style.border = "1px solid red";
		} else {
			$
					.ajax({
						type : 'POST',
						url : "agregarTemporada",
						dataType : 'json',
						data : {
							nombreTemporada : nombreTemporada,
							fechaInicio : fechaInicio,
							fechaTermino : fechaTermino
						},
						success : function(data) {
							if (data.idTemporada > 0) {
								$('#modalAgregarTemporada').modal('hide');

								var tabla = $('#listaTemporadas').dataTable();
								var num = tabla.fnSettings().fnRecordsTotal();

								// Formatear fechas
								var fechaInicio = moment(data.fechaInicio,
										'YYYY/MM/DD');
								fechaInicio = fechaInicio.format('DD-MM-YYYY');

								var fechaTermino = moment(data.fechaTermino,
										'YYYY/MM/DD');
								fechaTermino = fechaTermino
										.format('DD-MM-YYYY');

								var estado;
								if (data.estado == true) {
									estado = "Temporada Activa";
								} else {
									estado = "Temporada Finalizada";
								}

								// Actualizar tabla

								// Actualizar el data table
								$
										.ajax({
											type : 'POST',
											url : "obtenerListaTemporadas",
											dataType : 'json',
											success : function(data) {

												if (!$.isEmptyObject(data)) {
													// vaciar datatable
													var oTable = $(
															'#listaTemporadas')
															.dataTable();
													oTable.fnClearTable();

													// Llenar data table
													for (var i = 0; i < data.length; i++) {

														// Formatear fechas
														var fechaInicio = moment(
																data[i].fechaInicio,
																'YYYY/MM/DD');
														fechaInicio = fechaInicio
																.format('DD-MM-YYYY');

														var fechaTermino = moment(
																data[i].fechaTermino,
																'YYYY/MM/DD');
														fechaTermino = fechaTermino
																.format('DD-MM-YYYY');

														var estado;
														if (data[i].estado == true) {
															estado = "Temporada Activa";
														} else {
															estado = "Temporada Finalizada";
														}

														if (data[i].estado == true) {
															$(
																	'#listaTemporadas')
																	.dataTable()
																	.fnAddData(

																			[
																					i + 1,
																					data[i].nombre,
																					fechaInicio,
																					fechaTermino,
																					estado,
																					'<a href="#" title="Editar Temporada" onclick="editarTemporada('
																							+ data[i].idTemporada
																							+ ');"><i class="fa fa-edit fa-lg" style="color: #1CE4D0"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" title="Eliminar Temporada" onclick="eliminarTemporada('
																							+ data[i].idTemporada
																							+ ');"><i class="fa fa-trash-o fa-lg" style="color: red"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" title="Finalizar Temporada" onclick="finalizarTemporada('
																							+ data[i].idTemporada
																							+ ');"><i class="fa fa-check fa-lg" style="color: green"></i></a>' ]

																	);
														} else {
															$(
																	'#listaTemporadas')
																	.dataTable()
																	.fnAddData(

																			[
																					i + 1,
																					data[i].nombre,
																					fechaInicio,
																					fechaTermino,
																					estado,
																					'' ]

																	);
														}

													}
												}

											},
											error : function(jqXHR, errorThrown) {
												toastr
														.error("Error al obtener las temporadas");
											}
										});

								toastr
										.success("Temporada agregada correctamente");
							}

						},
						error : function(jqXHR, errorThrown) {
							toastr.error("Error al agregar la temporada");
						}
					});
		}

	}

}

function editarTemporada(idTemporada) {
	console.log(idTemporada);

	if (idTemporada > 0) {
		// Obtener los datos del insumo
		$.ajax({
			type : 'POST',
			url : "obtenerTemporadaAEditar",
			dataType : 'json',
			data : {
				idTemporada : idTemporada
			},
			success : function(data) {
				console.log(data);
				if (!$.isEmptyObject(data)) {
					// Cargar los datos en el modal
					$('#nombreTemporadaEditar').val(data.nombre);
					$('#fechaInicioEditar').val(data.fechaInicio);
					$('#fechaTerminoEditar').val(data.fechaTermino);

					$('#idTemporadaEditar').val(data.idTemporada);

					$('#modalEditarTemporada').modal('show');

				}

			},
			error : function(jqXHR, errorThrown) {
				toastr.error("Error al obtener los datos de la temporada");
			}
		});
	}

}

function eliminarTemporada(idTemporada) {
	console.log(idTemporada);

	if (idTemporada > 0) {
		swal(
				{
					title : "¿Está seguro de eliminar la temporada?",
					text : "Esta acción no podrá ser recuperada",
					type : "warning",
					showCancelButton : true,
					confirmButtonClass : "btn-danger",
					cancelButtonText : "Cancelar",
					confirmButtonText : "Si, Eliminar",
					closeOnConfirm : false
				},
				function() {

					// Ajax para eliminar
					$
							.ajax({
								type : 'POST',
								url : "eliminarTemporada",
								dataType : 'json',
								data : {
									idTemporada : idTemporada
								},
								success : function(data) {
									if (data == true) {
										swal.close();
										toastr
												.success("Temporada eliminada correctamente");

										// Actualizar el data table
										$
												.ajax({
													type : 'POST',
													url : "obtenerListaTemporadas",
													dataType : 'json',
													success : function(data) {

														if (!$
																.isEmptyObject(data)) {
															// vaciar datatable
															var oTable = $(
																	'#listaTemporadas')
																	.dataTable();
															oTable
																	.fnClearTable();

															// Llenar data table
															for (var i = 0; i < data.length; i++) {

																// Formatear
																// fechas
																var fechaInicio = moment(
																		data[i].fechaInicio,
																		'YYYY/MM/DD');
																fechaInicio = fechaInicio
																		.format('DD-MM-YYYY');

																var fechaTermino = moment(
																		data[i].fechaTermino,
																		'YYYY/MM/DD');
																fechaTermino = fechaTermino
																		.format('DD-MM-YYYY');

																var estado;
																if (data[i].estado == true) {
																	estado = "Temporada Activa";
																} else {
																	estado = "Temporada Finalizada";
																}

																if (data[i].estado == true) {
																	$(
																			'#listaTemporadas')
																			.dataTable()
																			.fnAddData(

																					[
																							i + 1,
																							data[i].nombre,
																							fechaInicio,
																							fechaTermino,
																							estado,
																							'<a href="#" title="Editar Temporada" onclick="editarTemporada('
																									+ data[i].idTemporada
																									+ ');"><i class="fa fa-edit fa-lg" style="color: #1CE4D0"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" title="Eliminar Temporada" onclick="eliminarTemporada('
																									+ data[i].idTemporada
																									+ ');"><i class="fa fa-trash-o fa-lg" style="color: red"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" title="Finalizar Temporada" onclick="finalizarTemporada('
																									+ data[i].idTemporada
																									+ ');"><i class="fa fa-check fa-lg" style="color: green"></i></a>' ]

																			);
																} else {
																	$(
																			'#listaTemporadas')
																			.dataTable()
																			.fnAddData(

																					[
																							i + 1,
																							data[i].nombre,
																							fechaInicio,
																							fechaTermino,
																							estado,
																							'' ]

																			);
																}

															}
														}

													},
													error : function(jqXHR,
															errorThrown) {
														toastr
																.error("Error al obtener las temporadas");
													}
												});
									} else {
										toastr
												.error("Error al obtener los insumos");
									}

								},
								error : function(jqXHR, errorThrown) {
									toastr.error("Error al eliminar el insumo");
								}
							});

				});
	}

}

function guardarDatosTemporadaEditar() {
	// Obtener los datos

	var idTemporada = $('#idTemporadaEditar').val();
	var nombreTemporada = $('#nombreTemporadaEditar').val();
	var fechaInicio = $('#fechaInicioEditar').val();
	var fechaTermino = $('#fechaTerminoEditar').val();

	console.log(nombreTemporada);
	console.log(fechaInicio);
	console.log(fechaTermino);

	// Validacion para el nombre
	if (nombreTemporada == "") {
		document.getElementById('errorNombreTemporadaEditar').style.display = 'inline';
		document.getElementById('nombreTemporadaEditar').style.border = "1px solid red";
	} else {
		document.getElementById('errorNombreTemporadaEditar').style.display = 'none';
		document.getElementById('nombreTemporadaEditar').style.border = "";
	}

	// Validacion para el tipo
	if (fechaInicio == "") {
		document.getElementById('errorFechaInicioEditar').style.display = 'inline';
		document.getElementById('fechaInicioEditar').style.border = "1px solid red";
	} else {
		document.getElementById('errorFechaInicioEditar').style.display = 'none';
		document.getElementById('fechaInicioEditar').style.border = "";
	}

	// Validacion para la unidad de medida
	if (fechaTermino == "") {
		document.getElementById('errorFechaTerminoEditar').style.display = 'inline';
		document.getElementById('fechaTerminoEditar').style.border = "1px solid red";
	} else {
		document.getElementById('errorFechaTerminoEditar').style.display = 'none';
		document.getElementById('fechaTerminoEditar').style.border = "";
	}

	if (nombreTemporada != "" && fechaInicio != "" && fechaTermino != ""
			&& idTemporada > 0) {

		// Validar que la fecha de inicio sea menor a la fecha de termino
		if (fechaTermino < fechaInicio) {
			document.getElementById('errorFechaTerminoMenorEditar').style.display = 'inline';
			document.getElementById('fechaTerminoEditar').style.border = "1px solid red";
		} else {
			$
					.ajax({
						type : 'POST',
						url : "editarTemporada",
						dataType : 'json',
						data : {
							idTemporada : idTemporada,
							nombreTemporada : nombreTemporada,
							fechaInicio : fechaInicio,
							fechaTermino : fechaTermino
						},
						success : function(data) {
							if (data == true) {

								// Actualizar el data table
								$
										.ajax({
											type : 'POST',
											url : "obtenerListaTemporadas",
											dataType : 'json',
											success : function(data) {

												if (!$.isEmptyObject(data)) {
													// vaciar datatable
													var oTable = $(
															'#listaTemporadas')
															.dataTable();
													oTable.fnClearTable();

													// Llenar data table
													for (var i = 0; i < data.length; i++) {

														// Formatear fechas
														var fechaInicio = moment(
																data[i].fechaInicio,
																'YYYY/MM/DD');
														fechaInicio = fechaInicio
																.format('DD-MM-YYYY');

														var fechaTermino = moment(
																data[i].fechaTermino,
																'YYYY/MM/DD');
														fechaTermino = fechaTermino
																.format('DD-MM-YYYY');

														var estado;
														if (data[i].estado == true) {
															estado = "Temporada Activa";
														} else {
															estado = "Temporada Finalizada";
														}

														if (data[i].estado == true) {
															$(
																	'#listaTemporadas')
																	.dataTable()
																	.fnAddData(

																			[
																					i + 1,
																					data[i].nombre,
																					fechaInicio,
																					fechaTermino,
																					estado,
																					'<a href="#" title="Editar Temporada" onclick="editarTemporada('
																							+ data[i].idTemporada
																							+ ');"><i class="fa fa-edit fa-lg" style="color: #1CE4D0"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" title="Eliminar Temporada" onclick="eliminarTemporada('
																							+ data[i].idTemporada
																							+ ');"><i class="fa fa-trash-o fa-lg" style="color: red"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" title="Finalizar Temporada" onclick="finalizarTemporada('
																							+ data[i].idTemporada
																							+ ');"><i class="fa fa-check fa-lg" style="color: green"></i></a>' ]

																	);
														} else {
															$(
																	'#listaTemporadas')
																	.dataTable()
																	.fnAddData(

																			[
																					i + 1,
																					data[i].nombre,
																					fechaInicio,
																					fechaTermino,
																					estado,
																					'' ]

																	);
														}

													}
												}

												// Close modal
												$('#modalEditarTemporada')
														.modal('hide');

											},
											error : function(jqXHR, errorThrown) {
												toastr
														.error("Error al obtener las temporadas");
											}
										});

								toastr
										.success("Temporada editada correctamente");

							}

						},
						error : function(jqXHR, errorThrown) {
							toastr.error("Error al agregar la temporada");
						}
					});
		}

	}

}

function finalizarTemporada(idTemporada) {
	if (idTemporada > 0) {
		swal(
				{
					title : "¿Está seguro de finalizar la temporada?",
					text : "Esta acción no podrá ser recuperada",
					type : "warning",
					showCancelButton : true,
					confirmButtonClass : "btn-danger",
					cancelButtonText : "Cancelar",
					confirmButtonText : "Si, Finalizar",
					closeOnConfirm : false
				},
				function() {
					swal.close();
					$
							.ajax({
								type : 'POST',
								url : "finalizarTemporada",
								dataType : 'json',
								data : {
									idTemporada : idTemporada
								},
								success : function(data) {
									console.log(data);
									if (data == true) {
										// Actualizar el data table
										$
												.ajax({
													type : 'POST',
													url : "obtenerListaTemporadas",
													dataType : 'json',
													success : function(data) {

														if (!$
																.isEmptyObject(data)) {
															// vaciar datatable
															var oTable = $(
																	'#listaTemporadas')
																	.dataTable();
															oTable
																	.fnClearTable();

															// Llenar data table
															for (var i = 0; i < data.length; i++) {

																// Formatear
																// fechas
																var fechaInicio = moment(
																		data[i].fechaInicio,
																		'YYYY/MM/DD');
																fechaInicio = fechaInicio
																		.format('DD-MM-YYYY');

																var fechaTermino = moment(
																		data[i].fechaTermino,
																		'YYYY/MM/DD');
																fechaTermino = fechaTermino
																		.format('DD-MM-YYYY');

																var estado;
																if (data[i].estado == true) {
																	estado = "Temporada Activa";
																} else {
																	estado = "Temporada Finalizada";
																}

																if (data[i].estado == true) {
																	$(
																			'#listaTemporadas')
																			.dataTable()
																			.fnAddData(

																					[
																							i + 1,
																							data[i].nombre,
																							fechaInicio,
																							fechaTermino,
																							estado,
																							'<a href="#" title="Editar Temporada" onclick="editarTemporada('
																									+ data[i].idTemporada
																									+ ');"><i class="fa fa-edit fa-lg" style="color: #1CE4D0"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" title="Eliminar Temporada" onclick="eliminarTemporada('
																									+ data[i].idTemporada
																									+ ');"><i class="fa fa-trash-o fa-lg" style="color: red"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" title="Finalizar Temporada" onclick="finalizarTemporada('
																									+ data[i].idTemporada
																									+ ');"><i class="fa fa-check fa-lg" style="color: green"></i></a>' ]

																			);
																} else {
																	$(
																			'#listaTemporadas')
																			.dataTable()
																			.fnAddData(

																					[
																							i + 1,
																							data[i].nombre,
																							fechaInicio,
																							fechaTermino,
																							estado,
																							'' ]

																			);
																}

															}
														}

													},
													error : function(jqXHR,
															errorThrown) {
														toastr
																.error("Error al obtener las temporadas");
													}
												});

										toastr
												.success("La temporada seleccionada ha finalizado");
									}
								},
								error : function(jqXHR, errorThrown) {
									alert("Error al obtener los productos");
								}
							});
				});

	}
}

$('#listaTemporadas').DataTable({
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
		"sInfoEmpty" : "",
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