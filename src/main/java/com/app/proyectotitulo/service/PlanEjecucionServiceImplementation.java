package com.app.proyectotitulo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.proyectotitulo.repository.PlanEjecucionRepository;

@Service
public class PlanEjecucionServiceImplementation implements PlanEjecucionService {

	private PlanEjecucionRepository planEjecucionRepo;

	@Autowired
	public void setPlanEjecucionRepository(PlanEjecucionRepository planEjecucionRepository) {
		planEjecucionRepo = planEjecucionRepository;
	}

}
