package com.app.proyectotitulo.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.app.proyectotitulo.DAO.ReporteProductoDAO;
import com.app.proyectotitulo.TO.DatosCosechaTO;
import com.app.proyectotitulo.TO.PlanTO;
import com.app.proyectotitulo.TO.ReporteProductoTO;
import com.app.proyectotitulo.domain.Actividad_Realizada;
import com.app.proyectotitulo.domain.Empleado;
import com.app.proyectotitulo.domain.Plan_Ejecucion;
import com.app.proyectotitulo.domain.Temporada;
import com.app.proyectotitulo.service.ActividadInsumoService;
import com.app.proyectotitulo.service.ActividadRealizadaService;
import com.app.proyectotitulo.service.PlanEjecucionService;
import com.app.proyectotitulo.service.TemporadaService;
import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Image;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.TabSettings;
import com.itextpdf.text.Font.FontFamily;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPCellEvent;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

@Controller
public class ReportesController {

	@Autowired
	private PlanEjecucionService planEjecucionService;

	@Autowired
	private TemporadaService temporadaService;

	@Autowired
	private ActividadRealizadaService actividadRealizadaService;

	@Autowired
	private ActividadInsumoService actividadInsumoService;

	@RequestMapping(value = "rendimientoProducto")
	public ModelAndView rendimientoSector(ModelAndView vista, HttpServletRequest request, HttpSession sesion) {

		sesion = request.getSession(true);
		Empleado e = (Empleado) sesion.getAttribute("empleado");

		if (e != null) {

			if (e.getCargo().equalsIgnoreCase("Administrador") || e.getCargo().equalsIgnoreCase("Gerente")) {

				vista.setViewName("rendimientoProducto");

			} else {
				vista.setViewName("login");
				vista.addObject("empleado", new Empleado());
				vista.addObject("accesoNoAutorizado", "No tiene acceso a esta funcionalidad");
			}

		} else {
			vista.setViewName("login");
			vista.addObject("empleado", new Empleado());
			vista.addObject("sesionExpirada", "Su sesión ha expirado");

		}

		return vista;
	}

	@RequestMapping(value = "obtenerDatosRendimientoProductos")
	public @ResponseBody LinkedList<DatosCosechaTO> obtenerDatosRendimientoProductos() {

		// Obtener planes
		ReporteProductoDAO reporteProductoDAO = new ReporteProductoDAO();
		LinkedList<PlanTO> listaPlanes = reporteProductoDAO.planes();

		LinkedList<ReporteProductoTO> lista = new LinkedList<>();
		LinkedList<DatosCosechaTO> datos = new LinkedList<>();
		DatosCosechaTO result = null;
		if (!listaPlanes.isEmpty()) {
			for (int i = 0; i < listaPlanes.size(); i++) {
				result = new DatosCosechaTO();
				lista = reporteProductoDAO.getDatosCosechaProducto(listaPlanes.get(i).getId());
				if (!lista.isEmpty()) {
					result.setNombrePlan(listaPlanes.get(i).getNombre());
					result.setDatos(lista);
					datos.add(result);
				} else {
					result.setNombrePlan(listaPlanes.get(i).getNombre());
					result.setDatos(new LinkedList<>());
					datos.add(result);
				}
			}

		}

		return datos;

	}

	@RequestMapping(value = "generarReporteProductos")
	public void generarReporteProductos(HttpServletResponse response) throws Exception {

		// Fecha emision
		LocalDateTime ldt = LocalDateTime.now();

		// Obtener todos los datos

		// Obtener planes
		ReporteProductoDAO reporteProductoDAO = new ReporteProductoDAO();
		LinkedList<PlanTO> listaPlanes = reporteProductoDAO.planes();

		LinkedList<ReporteProductoTO> lista = new LinkedList<>();
		LinkedList<DatosCosechaTO> datos = new LinkedList<>();
		DatosCosechaTO result = null;
		if (!listaPlanes.isEmpty()) {
			for (int i = 0; i < listaPlanes.size(); i++) {
				result = new DatosCosechaTO();
				lista = reporteProductoDAO.getDatosCosechaProducto(listaPlanes.get(i).getId());
				if (!lista.isEmpty()) {
					result.setNombrePlan(listaPlanes.get(i).getNombre());
					result.setDatos(lista);
					datos.add(result);
				} else {
					result.setNombrePlan(listaPlanes.get(i).getNombre());
					result.setDatos(new LinkedList<>());
					datos.add(result);
				}
			}

		}

		if (!datos.isEmpty()) {
			// Generar Reporte
			// Escribir PDF

			String FILE_NAME = "ReporteProductos.pdf";

			// Declaramos un documento como un objecto Document.
			Document documento = new Document(PageSize.LETTER, 0, 0, 0, 0);
			documento.setMargins(0, 0, 0, 0);

			// writer es declarado como el método utilizado para escribir en el archivo.
			PdfWriter pdfWriter = null;

			try {
				// Obtenemos la instancia del archivo a utilizar.
				pdfWriter = PdfWriter.getInstance(documento, new FileOutputStream(new File(FILE_NAME)));
			} catch (FileNotFoundException | DocumentException ex) {
				ex.getMessage();
			}

			// Abrimos el documento a editar.
			documento.open();

			// Creamos un párrafo nuevo llamado "saltoLines" para espaciar los elementos.
			Paragraph saltoLinea = new Paragraph();
			saltoLinea.add("\n");

			// Declaramos un texto como Paragraph. Le podemos dar formato alineado, tamaño,
			// color, etc.
			Paragraph titulo = new Paragraph();

			Paragraph fecha_emision = new Paragraph();
			fecha_emision.setFont(new Font(FontFamily.TIMES_ROMAN, 14));
			fecha_emision.setAlignment(Element.ALIGN_LEFT);
			fecha_emision
					.add("Fecha de emisión: " + DateTimeFormatter.ofPattern("MM-dd-yyyy", Locale.ENGLISH).format(ldt));

			Image imagen = Image.getInstance("logo.png");
			imagen.scaleToFit(200, 400);
			imagen.setAlignment(Element.ALIGN_RIGHT);

			titulo.setFont(new Font(FontFamily.TIMES_ROMAN, 20, Font.BOLD));
			titulo.setAlignment(Element.ALIGN_CENTER);
			titulo.add("Reporte Cosecha Productos");

			// Datos Productos

			// Recorrer arreglo

			System.out.println(datos.size());

			// Agregamos el texto al documento.
			documento.add(fecha_emision);
			documento.add(imagen);
			documento.add(saltoLinea);

			documento.add(titulo);
			documento.add(saltoLinea);

			for (int i = 0; i < datos.size(); i++) {

				PdfPCell cell3;
				PdfPCellEvent roundRectangle3 = new RoundRectangle();
				// outer table
				PdfPTable outertable3 = new PdfPTable(1);
				// inner table 1
				PdfPTable innertable3 = new PdfPTable(6);
				innertable3.setWidths(new int[] { 3, 20, 10, 10, 10, 10 });

				Paragraph titulo4 = new Paragraph();

				PdfPCell cell4;
				PdfPCellEvent roundRectangle4 = new RoundRectangle();
				// outer table
				PdfPTable outertable4 = new PdfPTable(1);
				// inner table 1
				PdfPTable innertable4 = new PdfPTable(6);
				innertable4.setWidths(new int[] { 3, 20, 10, 10, 10, 10 });

				Paragraph titulo2 = new Paragraph();
				titulo2.setFont(new Font(FontFamily.TIMES_ROMAN, 14, Font.BOLD));
				titulo2.setTabSettings(new TabSettings(56f));
				titulo2.add(Chunk.TABBING);
				titulo2.add(datos.get(i).getNombrePlan());

				documento.add(saltoLinea);
				documento.add(titulo2);

				/////////////////////////////////////////
				//////////////////////////////////////// Datos del plan

				//
				//
				//
				//
				// Agregar los datos
				//
				//
				//

				if (datos.get(i).getDatos().size() > 0) {
					// Titulos tabla
					// first row
					// column 1
					cell3 = new PdfPCell(new Phrase("N°"));
					cell3.setBorderColorBottom(BaseColor.BLACK);
					cell3.setBorder(Rectangle.NO_BORDER);
					innertable3.addCell(cell3);
					// column 2
					cell3 = new PdfPCell(new Phrase("Temporada"));
					cell3.setBorderColorBottom(BaseColor.BLACK);
					cell3.setBorder(Rectangle.NO_BORDER);
					innertable3.addCell(cell3);

					// column 3
					cell3 = new PdfPCell(new Phrase("Fecha Inicio"));
					cell3.setBorderColorBottom(BaseColor.BLACK);
					cell3.setBorder(Rectangle.NO_BORDER);
					innertable3.addCell(cell3);

					// column 4
					cell3 = new PdfPCell(new Phrase("Fecha Término"));
					cell3.setBorderColorBottom(BaseColor.BLACK);
					cell3.setBorder(Rectangle.NO_BORDER);
					innertable3.addCell(cell3);

					// column 5
					cell3 = new PdfPCell(new Phrase("Cantidad Cosechada"));
					cell3.setBorderColorBottom(BaseColor.BLACK);
					cell3.setBorder(Rectangle.NO_BORDER);
					innertable3.addCell(cell3);

					// column 6
					cell3 = new PdfPCell(new Phrase("Costo Total"));
					cell3.setBorderColorBottom(BaseColor.BLACK);
					cell3.setBorder(Rectangle.NO_BORDER);
					innertable3.addCell(cell3);

					// spacing
					cell3 = new PdfPCell();
					cell3.setColspan(5);
					cell3.setFixedHeight(3);
					cell3.setBorder(Rectangle.NO_BORDER);
					innertable3.addCell(cell3);

					// first nested table
					cell3 = new PdfPCell(innertable3);
					cell3.setCellEvent(roundRectangle3);
					cell3.setBorder(Rectangle.NO_BORDER);
					cell3.setPadding(8);
					outertable3.addCell(cell3);

					// Comenzar a colocar los datos

					int total = 0;

					/*
					 * for (int i = 0; i < detalle.size(); i++) { total +=
					 * detalle.get(i).getCantidadRecibida(); // first row // column 1 cell4 = new
					 * PdfPCell(new Phrase(i + 1 + "")); cell4.setBorder(Rectangle.NO_BORDER);
					 * innertable4.addCell(cell4); // column 2 cell4 = new PdfPCell(new
					 * Phrase(detalle.get(i).getCatalogoProducto().getCodigo()));
					 * cell4.setBorder(Rectangle.NO_BORDER); innertable4.addCell(cell4);
					 * 
					 * // column 3 cell4 = new PdfPCell(new
					 * Phrase(detalle.get(i).getCatalogoProducto().getNombre()));
					 * cell4.setBorder(Rectangle.NO_BORDER); innertable4.addCell(cell4);
					 * 
					 * // column 4 cell4 = new PdfPCell(new
					 * Phrase(detalle.get(i).getCatalogoProducto().getCategoriaSubcategoria()
					 * .getCategoria().getNombre())); cell4.setBorder(Rectangle.NO_BORDER);
					 * innertable4.addCell(cell4);
					 * 
					 * // column 5 cell4 = new PdfPCell(new
					 * Phrase(detalle.get(i).getCantidadRecibida() + ""));
					 * cell4.setBorder(Rectangle.NO_BORDER); innertable4.addCell(cell4);
					 * 
					 * // spacing cell4 = new PdfPCell(); cell4.setColspan(5);
					 * cell4.setFixedHeight(3); cell4.setBorder(Rectangle.NO_BORDER);
					 * innertable4.addCell(cell4);
					 * 
					 * }
					 */

					// first row
					/*
					 * // column 1 cell4 = new PdfPCell(new Phrase());
					 * cell4.setBorder(Rectangle.NO_BORDER); innertable4.addCell(cell4); // column 2
					 * cell4 = new PdfPCell(new Phrase()); cell4.setBorder(Rectangle.NO_BORDER);
					 * innertable4.addCell(cell4);
					 * 
					 */

					DecimalFormat formatea = new DecimalFormat("###,###.##");

					// Recorrer datos de temporadas
					for (int j = 0; j < datos.get(i).getDatos().size(); j++) {
						// column 1
						cell4 = new PdfPCell(new Phrase((j + 1) + ""));
						cell4.setBorder(Rectangle.NO_BORDER);
						innertable4.addCell(cell4);

						// column 2
						cell4 = new PdfPCell(new Phrase(datos.get(i).getDatos().get(j).getNombreTemporada()));
						cell4.setBorder(Rectangle.NO_BORDER);
						innertable4.addCell(cell4);

						// column 3
						cell4 = new PdfPCell(new Phrase(new SimpleDateFormat("dd-MM-yyyy")
								.format(datos.get(i).getDatos().get(j).getFechaInicio())));
						cell4.setBorder(Rectangle.NO_BORDER);
						innertable4.addCell(cell4);

						// column 4
						cell4 = new PdfPCell(new Phrase(new SimpleDateFormat("dd-MM-yyyy")
								.format(datos.get(i).getDatos().get(j).getFechaTermino())));
						cell4.setBorder(Rectangle.NO_BORDER);
						innertable4.addCell(cell4);

						// column 5
						cell4 = new PdfPCell(new Phrase(
								formatea.format(datos.get(i).getDatos().get(j).getCantidadCosechada()) + " Kg."));
						cell4.setBorder(Rectangle.NO_BORDER);
						innertable4.addCell(cell4);

						// column 6
						cell4 = new PdfPCell(
								new Phrase("$ " + formatea.format(datos.get(i).getDatos().get(j).getCosto())));
						cell4.setBorder(Rectangle.NO_BORDER);
						innertable4.addCell(cell4);

						// column 7
						cell4 = new PdfPCell();
						cell4.setBorder(Rectangle.NO_BORDER);
						innertable4.addCell(cell4);

						// spacing
						cell4 = new PdfPCell();
						cell4.setColspan(5);
						cell4.setFixedHeight(3);
						cell4.setBorder(Rectangle.NO_BORDER);
						innertable4.addCell(cell4);
						total += datos.get(i).getDatos().get(j).getCantidadCosechada();
					}

					/*
					 * // column 1 cell4 = new PdfPCell(new Phrase());
					 * cell4.setBorder(Rectangle.NO_BORDER); innertable4.addCell(cell4);
					 * 
					 * // column 2 cell4 = new PdfPCell(new Phrase());
					 * cell4.setBorder(Rectangle.NO_BORDER); innertable4.addCell(cell4);
					 * 
					 * // column 3 cell4 = new PdfPCell(new Phrase());
					 * cell4.setBorder(Rectangle.NO_BORDER); innertable4.addCell(cell4);
					 * 
					 * // column 4 cell4 = new PdfPCell(new Phrase("Total Histórico"));
					 * cell4.setBorder(Rectangle.NO_BORDER); innertable4.addCell(cell4);
					 * 
					 * // column 5 cell4 = new PdfPCell(new Phrase(formatea.format(total) +
					 * " Kg.")); cell4.setBorder(Rectangle.NO_BORDER); innertable4.addCell(cell4);
					 * 
					 * // spacing cell4 = new PdfPCell(); cell4.setColspan(5);
					 * cell4.setFixedHeight(3); cell4.setBorder(Rectangle.NO_BORDER);
					 * innertable4.addCell(cell4);
					 * 
					 */

					// first nested table
					cell4 = new PdfPCell(innertable4);
					cell4.setCellEvent(roundRectangle4);
					cell4.setBorder(Rectangle.NO_BORDER);
					cell4.setPadding(8);
					outertable4.addCell(cell4);

				} else {
					Paragraph titulo5 = new Paragraph();
					titulo5.setFont(new Font(FontFamily.TIMES_ROMAN, 12));
					titulo5.setTabSettings(new TabSettings(56f));
					titulo5.add(Chunk.TABBING);
					titulo5.add("Plan no ha sido ejecutado en ninguna temporada");
					documento.add(saltoLinea);
					documento.add(titulo5);

				}

				try {

					documento.add(titulo4);
					documento.add(saltoLinea);

					documento.add(outertable3);
					documento.add(outertable4);

				} catch (DocumentException ex) {
					ex.getMessage();
				}

			}

			// Cerramos el documento.
			documento.close();
			// Cerramos el writer.
			pdfWriter.close();

			//// Descargar PDF////

			FileInputStream fis = new FileInputStream(FILE_NAME);

			int read = 0;
			String contentType = "application/pdf";
			response.setContentType(contentType);
			response.setHeader("Content-Disposition", "attachment;filename=\"" + FILE_NAME + "\"");

			ServletOutputStream out = response.getOutputStream();

			byte[] bytes = new byte[1000];

			while ((read = fis.read(bytes)) != -1) {
				out.write(bytes, 0, read);
			}

			out.flush();
			out.close();

		}

	}

	class RoundRectangle implements PdfPCellEvent {
		public void cellLayout(PdfPCell cell, Rectangle rect, PdfContentByte[] canvas) {
			PdfContentByte cb = canvas[PdfPTable.LINECANVAS];
			cb.roundRectangle(rect.getLeft() + 1.5f, rect.getBottom() + 1.5f, rect.getWidth() - 3, rect.getHeight() - 3,
					4);
			cb.stroke();
		}

	}

	@RequestMapping(value = "generarReporteTemporada")
	public void generarReporteTemporada(@RequestParam int idTemporada, HttpServletResponse response) throws Exception {
		System.out.println(idTemporada);

		// Fecha emision
		LocalDateTime ldt = LocalDateTime.now();

		Paragraph fecha_emision = new Paragraph();
		fecha_emision.setFont(new Font(FontFamily.TIMES_ROMAN, 14));
		fecha_emision.setAlignment(Element.ALIGN_LEFT);
		fecha_emision.add("Fecha de emisión: " + DateTimeFormatter.ofPattern("MM-dd-yyyy", Locale.ENGLISH).format(ldt));

		List<Actividad_Realizada> lista = actividadRealizadaService.actividadesReporteTemporada(idTemporada);
		if (!lista.isEmpty()) {
			// Generar Reporte
			// Generar Reporte
			// Escribir PDF

			String FILE_NAME = "Reporte Temporada.pdf";

			// Declaramos un documento como un objecto Document.
			Document documento = new Document(PageSize.LETTER, 0, 0, 0, 0);
			documento.setMargins(0, 0, 0, 0);

			// writer es declarado como el método utilizado para escribir en el archivo.
			PdfWriter pdfWriter = null;

			try {
				// Obtenemos la instancia del archivo a utilizar.
				pdfWriter = PdfWriter.getInstance(documento, new FileOutputStream(new File(FILE_NAME)));
			} catch (FileNotFoundException | DocumentException ex) {
				ex.getMessage();
			}

			// Abrimos el documento a editar.
			documento.open();

			// Creamos un párrafo nuevo llamado "saltoLines" para espaciar los elementos.
			Paragraph saltoLinea = new Paragraph();
			saltoLinea.add("\n");

			// Declaramos un texto como Paragraph. Le podemos dar formato alineado, tamaño,
			// color, etc.
			Paragraph titulo = new Paragraph();

			Image imagen = Image.getInstance("logo.png");
			imagen.scaleToFit(200, 400);
			imagen.setAlignment(Element.ALIGN_RIGHT);

			titulo.setFont(new Font(FontFamily.TIMES_ROMAN, 20, Font.BOLD));
			titulo.setAlignment(Element.ALIGN_CENTER);
			titulo.add("Reporte " + lista.get(0).getTemporada().getNombre());

			// Datos Productos

			// Recorrer arreglo

			// Agregamos el texto al documento.
			documento.add(fecha_emision);
			documento.add(imagen);
			documento.add(saltoLinea);

			documento.add(titulo);
			documento.add(saltoLinea);

			PdfPCell cell3;
			PdfPCellEvent roundRectangle3 = new RoundRectangle();
			// outer table
			PdfPTable outertable3 = new PdfPTable(1);
			// inner table 1
			PdfPTable innertable3 = new PdfPTable(6);
			innertable3.setWidths(new int[] { 3, 15, 15, 10, 10, 10 });

			Paragraph titulo4 = new Paragraph();

			PdfPCell cell4;
			PdfPCellEvent roundRectangle4 = new RoundRectangle();
			// outer table
			PdfPTable outertable4 = new PdfPTable(1);
			// inner table 1
			PdfPTable innertable4 = new PdfPTable(6);
			innertable4.setWidths(new int[] { 3, 15, 15, 10, 10, 10 });

			// Titulos tabla
			// first row
			// column 1
			cell3 = new PdfPCell(new Phrase("N°"));
			cell3.setBorderColorBottom(BaseColor.BLACK);
			cell3.setBorder(Rectangle.NO_BORDER);
			innertable3.addCell(cell3);
			// column 2

			cell3 = new PdfPCell(new Phrase("Sector"));
			cell3.setBorderColorBottom(BaseColor.BLACK);
			cell3.setBorder(Rectangle.NO_BORDER);
			innertable3.addCell(cell3);

			// column 3
			cell3 = new PdfPCell(new Phrase("Predio"));
			cell3.setBorderColorBottom(BaseColor.BLACK);
			cell3.setBorder(Rectangle.NO_BORDER);
			innertable3.addCell(cell3);

			// column 4
			cell3 = new PdfPCell(new Phrase("Fecha Cosecha"));
			cell3.setBorderColorBottom(BaseColor.BLACK);
			cell3.setBorder(Rectangle.NO_BORDER);
			innertable3.addCell(cell3);

			// column 5
			cell3 = new PdfPCell(new Phrase("Cantidad Cosechada"));
			cell3.setBorderColorBottom(BaseColor.BLACK);
			cell3.setBorder(Rectangle.NO_BORDER);
			innertable3.addCell(cell3);

			// column 6
			cell3 = new PdfPCell(new Phrase("Costo"));
			cell3.setBorderColorBottom(BaseColor.BLACK);
			cell3.setBorder(Rectangle.NO_BORDER);
			innertable3.addCell(cell3);

			// spacing
			cell3 = new PdfPCell();
			cell3.setColspan(5);
			cell3.setFixedHeight(3);
			cell3.setBorder(Rectangle.NO_BORDER);
			innertable3.addCell(cell3);

			// first nested table
			cell3 = new PdfPCell(innertable3);
			cell3.setCellEvent(roundRectangle3);
			cell3.setBorder(Rectangle.NO_BORDER);
			cell3.setPadding(8);
			outertable3.addCell(cell3);

			documento.add(outertable3);
			int totalCosechado = 0;
			int costoTotal = 0;
			DecimalFormat formatea = new DecimalFormat("###,###.##");
			for (int i = 0; i < lista.size(); i++) {

				//
				//
				//
				//
				// Agregar los datos
				//
				//
				//

				// Comenzar a colocar los datos

				// column 1
				cell4 = new PdfPCell(new Phrase((i + 1) + ""));
				cell4.setBorder(Rectangle.NO_BORDER);
				innertable4.addCell(cell4);
				// column 2
				cell4 = new PdfPCell(new Phrase(lista.get(i).getPredio().getSector().getNombre()));
				cell4.setBorder(Rectangle.NO_BORDER);
				innertable4.addCell(cell4);

				// column 3
				cell4 = new PdfPCell(new Phrase(lista.get(i).getPredio().getNombre()));
				cell4.setBorder(Rectangle.NO_BORDER);
				innertable4.addCell(cell4);

				// column 4
				cell4 = new PdfPCell(
						new Phrase(new SimpleDateFormat("dd-MM-yyyy").format(lista.get(i).getFechaEjecucionReal())));
				cell4.setBorder(Rectangle.NO_BORDER);
				innertable4.addCell(cell4);

				// column 5
				cell4 = new PdfPCell(new Phrase(formatea.format(lista.get(i).getCantidadCosechada()) + " Kg."));
				cell4.setBorder(Rectangle.NO_BORDER);
				innertable4.addCell(cell4);

				// Costo
				Integer costo = actividadInsumoService.obtenerCostosTotales(lista.get(i).getPredio().getIdPredio(),
						lista.get(i).getTemporada().getIdTemporada());

				if (costo != null) {
					// column 6
					cell4 = new PdfPCell(new Phrase("$ " + formatea.format(costo)));
					cell4.setBorder(Rectangle.NO_BORDER);
					innertable4.addCell(cell4);
				}

				// column 7
				cell4 = new PdfPCell();
				cell4.setBorder(Rectangle.NO_BORDER);
				innertable4.addCell(cell4);

				// spacing
				cell4 = new PdfPCell();
				cell4.setColspan(5);
				cell4.setFixedHeight(3);
				cell4.setBorder(Rectangle.NO_BORDER);
				innertable4.addCell(cell4);

				totalCosechado += lista.get(i).getCantidadCosechada();
				costoTotal += costo;

			}

			// first nested table
			cell4 = new PdfPCell(innertable4);
			cell4.setCellEvent(roundRectangle4);
			cell4.setBorder(Rectangle.NO_BORDER);
			cell4.setPadding(8);
			outertable4.addCell(cell4);

			documento.add(outertable4);

			// Otro rectangulo para mostrar el total cosechado y el costo total
			PdfPCell cell5;
			PdfPCellEvent roundRectangle5 = new RoundRectangle();
			// outer table
			PdfPTable outertable5 = new PdfPTable(1);
			// inner table 1
			PdfPTable innertable5 = new PdfPTable(5);
			innertable5.setWidths(new int[] { 15, 15, 2, 15, 15 });

			documento.add(saltoLinea);
			documento.add(saltoLinea);

			// column 1
			cell5 = new PdfPCell(new Phrase("Total Cosechado: "));
			cell5.setBorder(Rectangle.NO_BORDER);
			innertable5.addCell(cell5);

			// column 2
			cell5 = new PdfPCell(new Phrase(formatea.format(totalCosechado) + " Kg."));
			cell5.setBorder(Rectangle.NO_BORDER);
			innertable5.addCell(cell5);

			// column 3
			cell5 = new PdfPCell(new Phrase());
			cell5.setBorder(Rectangle.NO_BORDER);
			innertable5.addCell(cell5);

			// column 4
			cell5 = new PdfPCell(new Phrase("Costo Total: "));
			cell5.setBorder(Rectangle.NO_BORDER);
			innertable5.addCell(cell5);

			// column 5
			cell5 = new PdfPCell(new Phrase("$ " + formatea.format(costoTotal)));
			cell5.setBorder(Rectangle.NO_BORDER);
			innertable5.addCell(cell5);

			// spacing
			cell5 = new PdfPCell();
			cell5.setColspan(5);
			cell5.setFixedHeight(3);
			cell5.setBorder(Rectangle.NO_BORDER);
			innertable5.addCell(cell5);

			// first nested table
			cell5 = new PdfPCell(innertable5);
			cell5.setCellEvent(roundRectangle5);
			cell5.setBorder(Rectangle.NO_BORDER);
			cell5.setPadding(8);
			outertable5.addCell(cell5);

			documento.add(outertable5);

			// Cerramos el documento.
			documento.close();
			// Cerramos el writer.
			pdfWriter.close();

			//// Descargar PDF////

			FileInputStream fis = new FileInputStream(FILE_NAME);

			int read = 0;
			String contentType = "application/pdf";
			response.setContentType(contentType);
			response.setHeader("Content-Disposition", "attachment;filename=\"" + FILE_NAME + "\"");

			ServletOutputStream out = response.getOutputStream();

			byte[] bytes = new byte[1000];

			while ((read = fis.read(bytes)) != -1) {
				out.write(bytes, 0, read);
			}

			out.flush();
			out.close();
		}
	}

	@RequestMapping(value = "cosechaTemporada")
	public ModelAndView cosechaTemporada(ModelAndView vista, HttpServletRequest request, HttpSession sesion) {

		sesion = request.getSession(true);
		Empleado e = (Empleado) sesion.getAttribute("empleado");

		if (e != null) {

			if (e.getCargo().equalsIgnoreCase("Administrador") || e.getCargo().equalsIgnoreCase("Gerente")) {

				vista.setViewName("cosechaPorTemporada");

				// Obtener todas las temporadas
				List<Temporada> lista = temporadaService.listaTemporadas(false);
				vista.addObject("listaTemporadas", lista);

			} else {
				vista.setViewName("login");
				vista.addObject("empleado", new Empleado());
				vista.addObject("accesoNoAutorizado", "No tiene acceso a esta funcionalidad");
			}

		} else {
			vista.setViewName("login");
			vista.addObject("empleado", new Empleado());
			vista.addObject("sesionExpirada", "Su sesión ha expirado");

		}

		return vista;
	}
}
