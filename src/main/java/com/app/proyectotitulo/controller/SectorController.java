package com.app.proyectotitulo.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import com.app.proyectotitulo.domain.Sector;
import com.app.proyectotitulo.service.SectorService;


@Controller
public class SectorController {
	
    
	@Autowired
	private SectorService sectorService;
	
    @RequestMapping(value="listarSectores")
    public ModelAndView totalSectores(ModelAndView vista) {
    	List<Sector> lista = sectorService.findAll();
    	if (!lista.isEmpty()) {
    		vista.addObject("sectores",lista );
			vista.setViewName("listarSectores");
		}else {
		    //vista.addObject("noHaySectores", " No existen sectores registrados");
			vista.setViewName("listarSectores");
		}
		return vista;
    }
    
	

		
	}

	

		
	

