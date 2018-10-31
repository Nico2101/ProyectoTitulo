//Abrir
$
		.ajax({
			type : 'POST',
			url : "obtenerDatosRendimientoProductos",
			dataType : 'json',
			success : function(data) {
				console.log(data);

				if (!$.isEmptyObject(data)) {
					// Crear Graficos

					for (var i = 0; i < data.length; i++) {
						var idGrafico = "grafico" + (i + 1);
						var divGrafico = '<div class="col-md-6">'
								+ '<div class="box box-primary">'
								+ '<div class="box-header with-border">'
								+ '<h3 class="box-title">'
								+ data[i].nombrePlan.substring(4)
								+ '</h3>'
								+ '<div class="box-tools pull-right">'
								+ '<button type="button" class="btn btn-box-tool" data-widget="collapse">'
								+ '<i class="fa fa-minus"></i>'
								+ '</button>'
								+ '<button type="button" class="btn btn-box-tool" data-widget="remove">'
								+ '<i class="fa fa-times"></i>'
								+ '</button>'
								+ '</div>'
								+ '</div>'
								+ '<div class="box-body">'
								+ '<div class="chart">'
								+ '<div id="divBarChart">'
								+ '<canvas id="'
								+ idGrafico
								+ '" style="height: 163px; width: 423px;" width="528" height="263"></canvas>'
								+ '</div>'
								+ '</div>'
								+ '</div>'
								+ '</div>'
								+ '</div>';

						$('#graficos').append(divGrafico);

						// Cargar datos al grafico
						var ejeX = Array();
						var datos = Array();
						var arregloColores = Array();
						for (var j = 0; j < data[i].datos.length; j++) {

							ejeX.push(data[i].datos[j].nombreTemporada);

							datos.push(data[i].datos[j].cantidadCosechada);

							// Codigo para generar los colores random
							var color = 'rgb('
									+ (Math.floor(Math.random() * 256)) + ','
									+ (Math.floor(Math.random() * 256)) + ','
									+ (Math.floor(Math.random() * 256)) + ')';

							arregloColores.push(color);
						}

						console.log(ejeX);
						console.log(datos);

						// Grafico de barras
						// Bar chart

						new Chart(
								document.getElementById(idGrafico),
								{
									type : 'bar',
									data : {
										labels : ejeX,
										datasets : [ {
											label : "Cantidad Cosechada",
											backgroundColor : arregloColores,
											data : datos
										} ]
									},
									options : {
										legend : {
											display : false
										},
										title : {
											display : true,
											text : ''
										},
										tooltips : {

											mode : 'index',
											intersect : false,
											callbacks : {
												label : function(tooltipItem,
														datos) {

													return datos.datasets[tooltipItem.datasetIndex].label
															+ " : "
															+ currency(
																	datos.datasets[tooltipItem.datasetIndex].data[tooltipItem.index],
																	1) + " Kg.";
												}
											}
										},

										scales : {
											yAxes : [ {
												ticks : {
													fontSize : 10,
													beginAtZero : true,
													callback : function(value) {
														return currency(value,
																1);
													}
												},
												scaleLabel : {
													display : true,
													labelString : 'Cantidad Cosechada (Kg.)'
												}
											} ],
											xAxes : [ {
												ticks : {
													fontSize : 10,
													autoSkip : false
												},
												scaleLabel : {
													display : true,
													labelString : 'Temporadas'
												}
											} ]
										}
									}
								});

					}

				}

				document.getElementById('imagen').style.display = 'none';
				document.getElementById('botonGenerarReporte').style.display = 'inline';

				document.getElementById('titulo').style.display = 'inline';

			},
			error : function(jqXHR, errorThrown) {
				alert("Error al obtener los datos");
			}
		});

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

function abrirModalTemporada() {
	// obtener las demas temporadas
	$
			.ajax({
				type : 'POST',
				url : "obtenerListaTemporadas",
				dataType : 'json',
				success : function(data) {
					console.log(data);
					if (!$.isEmptyObject(data)) {
						// Cargar el select
						$("#temporada").empty();
						$("#temporada")
								.append(
										'<option value="-1">Seleccione una temporada</option>');
						for (var i = 0; i < data.length; i++) {
							$("#temporada").append(
									'<option value=' + data[i].idTemporada
											+ '>' + data[i].nombre
											+ '</option>');

						}
						$('#modalReporteTemporada').modal('show');
					}

				},
				error : function(jqXHR, errorThrown) {
					alert("Error al obtener los productos");
				}
			});

}

function generarReporte() {
	// Obtener temporada
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
		$.ajax({
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

					toastr.error("No hay datos en la temporada seleccionada");
				}

			},
			error : function(jqXHR, errorThrown) {
				alert("Error al verificar la temporada");
			}
		});
	}

}