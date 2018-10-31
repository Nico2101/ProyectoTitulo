function sectorVacio() {
	nombreSector = $('#nombreSector').val();

	document.getElementById('errorNombre').style.display = 'none';
	document.getElementById('nombreSector').style.border = "";

}

function superficieVacia() {
	document.getElementById('errorSuperficie').style.display = 'none';
	document.getElementById('superficieSector').style.border = "";
}

function agregarSector() {

	$('#modalAgregarSector').modal('show');

	// Limpiar modal
	$('#nombreSector').val("");
	$('#superficieSector').val("");

	document.getElementById('errorNombre').style.display = 'none';
	document.getElementById('nombreSector').style.border = "";

	document.getElementById('errorSuperficie').style.display = 'none';
	document.getElementById('superficieSector').style.border = "";

}

function guardarDatosSector() {
	// Obtener los datos
	var nombreSector = $('#nombreSector').val();
	var superficieSector = $('#superficieSector').val();

	console.log(nombreSector);
	console.log(superficieSector);

	// Validacion para el nombre
	if (nombreSector == "") {
		document.getElementById('errorNombre').style.display = 'inline';
		document.getElementById('nombreSector').style.border = "1px solid red";
	} else {
		document.getElementById('errorNombre').style.display = 'none';
		document.getElementById('nombreSector').style.border = "";
	}

	// Validacion para la superficie
	if (superficieSector == "") {
		document.getElementById('errorSuperficie').style.display = 'inline';
		document.getElementById('superficieSector').style.border = "1px solid red";
	} else {
		// Validacion para la superficie
		if (superficieSector < 0 && superficieSector != "") {
			document.getElementById('errorSuperficie').style.display = 'none';
			document.getElementById('errorSuperficieNegativa').style.display = 'inline';
			document.getElementById('superficieSector').style.border = "1px solid red";
		} else {
			document.getElementById('errorSuperficieNegativa').style.display = 'none';
			document.getElementById('superficieSector').style.border = "";
		}

	}

	if (superficieSector != "" && superficieSector > 0) {
		document.getElementById('errorSuperficie').style.display = 'none';
		document.getElementById('superficieSector').style.border = "";
	}

	if (nombreSector != "" && superficieSector > 0) {

		$
				.ajax({
					type : 'POST',
					url : "verificarNombreRepetidoSector",
					dataType : 'json',
					async : false,
					data : {
						nombre : nombreSector
					},
					success : function(data) {
						if (data == true) {
							swal(
									{
										title : "Ya existe un sector con el nombre ingresado ¿Desea continuar?",
										text : "",
										type : "warning",
										showCancelButton : true,
										confirmButtonClass : "btn-danger",
										cancelButtonText : "Cancelar",
										confirmButtonText : "Si, continuar",
										closeOnConfirm : false
									},
									function() {

										$
												.ajax({
													type : 'POST',
													url : "agregarSector",
													dataType : 'json',
													data : {
														nombre : nombreSector,
														superficie : superficieSector,

													},

													success : function(data) {
														console.log(data);

														if (data.idSector > 0) {
															swal.close();
															$(
																	'#modalAgregarSector')
																	.modal(
																			'hide');

															// Actualizar el
															// data table
															$
																	.ajax({
																		type : 'POST',
																		url : "obtenerListaSectores",
																		dataType : 'json',
																		success : function(
																				data) {

																			if (!$
																					.isEmptyObject(data)) {
																				// vaciar
																				// datatable
																				var oTable = $(
																						'#listaSectores')
																						.dataTable();
																				oTable
																						.fnClearTable();

																				// Llenar
																				// data
																				// table
																				for (var i = 0; i < data.length; i++) {
																					$(
																							'#listaSectores')
																							.dataTable()
																							.fnAddData(

																									[
																											i + 1,
																											data[i].nombre,
																											data[i].superficie,
																											'<a href="#" onclick="editarSector('
																													+ data[i].idSector
																													+ ');"><i class="fa fa-edit fa-lg" style="color: #1CE4D0"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" onclick="eliminarSector('
																													+ data[i].idSector
																													+ ');"><i class="fa fa-trash-o fa-lg" style="color: red"></i></a>' ]

																							);
																				}
																			}

																		},
																		error : function(
																				jqXHR,
																				errorThrown) {
																			toastr
																					.error("Error al obtener los sectores");
																		}
																	});
															//

															toastr
																	.success("Sector agregado correctamente");
														} else {
															toastr
																	.error("Error al agregar el sector");
														}

													},
													error : function(jqXHR,
															errorThrown) {
														toastr
																.error("Error al agregar el sector");
													}

												});

									});

						} else {

							$
									.ajax({
										type : 'POST',
										url : "agregarSector",
										dataType : 'json',
										data : {
											nombre : nombreSector,
											superficie : superficieSector,

										},

										success : function(data) {
											console.log(data);

											if (data.idSector > 0) {
												$('#modalAgregarSector').modal(
														'hide');

												// Actualizar el data table
												$
														.ajax({
															type : 'POST',
															url : "obtenerListaSectores",
															dataType : 'json',
															success : function(
																	data) {

																if (!$
																		.isEmptyObject(data)) {
																	// vaciar
																	// datatable
																	var oTable = $(
																			'#listaSectores')
																			.dataTable();
																	oTable
																			.fnClearTable();

																	// Llenar
																	// data
																	// table
																	for (var i = 0; i < data.length; i++) {
																		$(
																				'#listaSectores')
																				.dataTable()
																				.fnAddData(

																						[
																								i + 1,
																								data[i].nombre,
																								data[i].superficie,
																								'<a href="#" onclick="editarSector('
																										+ data[i].idSector
																										+ ');"><i class="fa fa-edit fa-lg" style="color: #1CE4D0"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" onclick="eliminarSector('
																										+ data[i].idSector
																										+ ');"><i class="fa fa-trash-o fa-lg" style="color: red"></i></a>' ]

																				);
																	}
																}

															},
															error : function(
																	jqXHR,
																	errorThrown) {
																toastr
																		.error("Error al obtener los sectores");
															}
														});
												//

												toastr
														.success("Sector agregado correctamente");
											} else {
												toastr
														.error("Error al agregar el sector");
											}

										},
										error : function(jqXHR, errorThrown) {
											toastr
													.error("Error al agregar el sector");
										}

									});

						}
					},
					error : function(jqXHR, errorThrown) {
						toastr.error("Error, revisar datos");
					}

				});

	}
}

function editarSector(idSector) {
	console.log(idSector);

	if (idSector > 0) {
		// Obtener los datos del sector
		$
				.ajax({
					type : 'POST',
					url : "obtenerSectorAEditar",
					dataType : 'json',
					data : {
						idSector : idSector
					},
					success : function(data) {
						console.log(data);
						if (!$.isEmptyObject(data)) {
							// Cargar los datos en el modal
							$('#nombreSectorEditar').val(data.nombre);
							$('#superficieSectorEditar').val(data.superficie);

							document.getElementById('errorNombreEditar').style.display = 'none';
							document.getElementById('nombreSectorEditar').style.border = "";

							document.getElementById('errorSuperficieEditar').style.display = 'none';
							document.getElementById('superficieSectorEditar').style.border = "";

							document
									.getElementById('errorSuperficieNegativaEditar').style.display = 'none';
							document.getElementById('superficieSectorEditar').style.border = "";

							// Cargar el id del sector en el input oculto
							$('#idSectorEditar').val(idSector);

							$('#modalEditarSector').modal('show');

						}

					},
					error : function(jqXHR, errorThrown) {
						toastr.error("Error al editar el sector");
					}
				});
	}

}

function eliminarSector(idSector) {
	console.log(idSector);

	if (idSector > 0) {
		swal(
				{
					title : "¿Está seguro de eliminar el sector?",
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
								url : "eliminarSector",
								dataType : 'json',
								data : {
									idSector : idSector
								},
								success : function(data) {
									if (data == true) {
										swal.close();

										toastr
												.success("Sector eliminado correctamente");
										// Actualizar el data table
										$
												.ajax({
													type : 'POST',
													url : "obtenerListaSectores",
													dataType : 'json',
													success : function(data) {

														if (!$
																.isEmptyObject(data)) {
															// vaciar datatable
															var oTable = $(
																	'#listaSectores')
																	.dataTable();
															oTable
																	.fnClearTable();

															// Llenar data table
															for (var i = 0; i < data.length; i++) {
																$(
																		'#listaSectores')
																		.dataTable()
																		.fnAddData(

																				[
																						i + 1,
																						data[i].nombre,
																						data[i].superficie,
																						'<a href="#" onclick="editarSector('
																								+ data[i].idSector
																								+ ');"><i class="fa fa-edit fa-lg" style="color: #1CE4D0"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" onclick="eliminarSector('
																								+ data[i].idSector
																								+ ');"><i class="fa fa-trash-o fa-lg" style="color: red"></i></a>' ]

																		);
															}
														}

													},
													error : function(jqXHR,
															errorThrown) {
														toastr
																.error("Error al obtener los sectores");
													}
												});
										//

										// elimina los predios asociados a un
										// sector
										$
												.ajax({
													type : 'POST',
													url : "eliminarPrediosDeUnSector",
													dataType : 'json',
													data : {
														idSector : idSector
													},
													success : function(data) {
														if (data == true) {

														}

													},
													error : function(jqXHR,
															errorThrown) {

													}
												});
									} else {
										toastr
												.error("Error al obtener los sectores");

									}

								},
								error : function(jqXHR, errorThrown) {
									toastr.error("Error al eliminar sector");
								}
							});
				})
	}

}

function guardarDatosSectorEditar() {
	// Obtener los datos
	var nombreSector = $('#nombreSectorEditar').val();
	var superficie = $('#superficieSectorEditar').val();
	var idSector = $('#idSectorEditar').val();

	console.log(nombreSector);
	console.log(superficie);

	// Validacion para el nombre
	if (nombreSector == "") {
		document.getElementById('errorNombreEditar').style.display = 'inline';
		document.getElementById('nombreSectorEditar').style.border = "1px solid red";
	} else {
		document.getElementById('errorNombreEditar').style.display = 'none';
		document.getElementById('nombreSectorEditar').style.border = "";
	}

	// Validacion para la superficie
	if (superficie == "") {
		document.getElementById('errorSuperficieEditar').style.display = 'inline';
		document.getElementById('superficieSectorEditar').style.border = "1px solid red";
	} else {
		// Validacion para la superficie
		if (superficie < 0 && superficie != "") {
			document.getElementById('errorSuperficieEditar').style.display = 'none';
			document.getElementById('errorSuperficieNegativaEditar').style.display = 'inline';
			document.getElementById('superficieSectorEditar').style.border = "1px solid red";
		} else {
			document.getElementById('errorSuperficieNegativaEditar').style.display = 'none';
			document.getElementById('superficieSectorEditar').style.border = "";
		}

	}

	if (superficie != "" && superficie > 0) {
		document.getElementById('errorSuperficieEditar').style.display = 'none';
		document.getElementById('superficieSectorEditar').style.border = "";
	}

	if (nombreSector != "" && superficie > 0 && idSector > 0) {
		$
				.ajax({
					type : 'POST',
					url : "editarSector",
					dataType : 'json',
					data : {
						idSector : idSector,
						nombre : nombreSector,
						superficie : superficie,

					},
					success : function(data) {
						console.log(data);

						if (data == true) {

							// Actualizar el data table
							$
									.ajax({
										type : 'POST',
										url : "obtenerListaSectores",
										dataType : 'json',
										success : function(data) {

											if (!$.isEmptyObject(data)) {
												// vaciar datatable
												var oTable = $('#listaSectores')
														.dataTable();
												oTable.fnClearTable();

												// Llenar data table
												for (var i = 0; i < data.length; i++) {
													$('#listaSectores')
															.dataTable()
															.fnAddData(

																	[
																			i + 1,
																			data[i].nombre,
																			data[i].superficie,
																			'<a href="#" onclick="editarSector('
																					+ data[i].idSector
																					+ ');"><i class="fa fa-edit fa-lg" style="color: #1CE4D0"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" onclick="eliminarSector('
																					+ data[i].idSector
																					+ ');"><i class="fa fa-trash-o fa-lg" style="color: red"></i></a>' ]

															);
												}
												toastr
														.success("Sector editado correctamente");
											}

											// Close modal
											$('#modalEditarSector').modal(
													'hide');

										},
										error : function(jqXHR, errorThrown) {
											toastr
													.error("Error al obtener los sectores");
										}
									});

						} else {
							toastr.error("Error al editar el sector");
						}

					},
					error : function(jqXHR, errorThrown) {
						toastr.error("Error al editar el sector");
					}
				});
	}

}

function filterFloat(evt, input) {

	var key = window.Event ? evt.which : evt.keyCode;
	var chark = String.fromCharCode(key);
	var tempValue = input.value + chark;
	if (key >= 48 && key <= 57) {
		if (filter(tempValue) === false) {
			return false;
		} else {
			return true;
		}
	} else {
		if (key == 8 || key == 13 || key == 0) {
			return true;
		} else if (key == 46) {
			if (filter(tempValue) === false) {
				return false;
			} else {
				return true;
			}
		} else {
			return false;
		}
	}
}

function filter(__val__) {
	var preg = /^\d*$/;
	if (preg.test(__val__) === true) {
		return true;
	} else {
		return false;
	}

}

$('#listaSectores').DataTable({
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