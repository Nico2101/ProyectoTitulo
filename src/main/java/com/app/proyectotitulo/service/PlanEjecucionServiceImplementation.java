package com.app.proyectotitulo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.proyectotitulo.domain.Plan_Ejecucion;
import com.app.proyectotitulo.repository.PlanEjecucionRepository;

@Service
public class PlanEjecucionServiceImplementation implements PlanEjecucionService {

	private PlanEjecucionRepository planEjecucionRepo;

	@Autowired
	public void setPlanEjecucionRepository(PlanEjecucionRepository planEjecucionRepository) {
		planEjecucionRepo = planEjecucionRepository;
	}

	@Override
	public Plan_Ejecucion saveAndFlush(Plan_Ejecucion p) {
		// TODO Auto-generated method stub
		return planEjecucionRepo.saveAndFlush(p);
	}

	@Override
	public List<Plan_Ejecucion> listaPlanes(boolean planEliminado) {
		// TODO Auto-generated method stub
		return planEjecucionRepo.findByPlanEliminado(planEliminado);
	}

	@Override
	public Plan_Ejecucion buscarPlan(int idPlan) {
		// TODO Auto-generated method stub
		return planEjecucionRepo.findByIdPlanEjecucion(idPlan);
	}

	@Override
	public void eliminarPlan(Plan_Ejecucion p) {
		// TODO Auto-generated method stub
		planEjecucionRepo.save(p);
	}

}
