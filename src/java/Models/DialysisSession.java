/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Models;

import java.sql.Date;
import java.util.ArrayList;

/**
 *
 * @author Nevets
 */
public class DialysisSession {

    Patient patient = new Patient();
    String patientId;
    String sess_id,date, billno, paid;
    String patStart_time, patEnd_time;
    String sch_emrg, diag_id, diag_condn, mach_id, access_point, open_tech, close_tech;
    //pre-dialysis
    String pre_site_condn, pre_condn_no_expl, pre_patientWeight, pre_notes;
    String[] pre_patient_condns;

    //during dialysis
    ArrayList<DurDialSess> arrDurDial = new ArrayList<>();
    String drugs_given, drugs_issues;
    String hepari, UF;
    //post-dialysis
    String post_site_condn, post_condn_no_expl, post_patientWeight, post_notes;
    String[] post_patient_condns;
    String earlyDis, discharge, diet_notes, tech_signature, tech_reg,tech_thera,tech_dial,tech_othserv,
            tech_othservamt,centreNo,billingNo;
    ArrayList<PharmacyBill> tech_pharm = new ArrayList<>();
    ArrayList<Consumable> tech_consumables = new ArrayList<>();

    public String getCentreNo() {
        return centreNo;
    }

    public void setCentreNo(String centreNo) {
        this.centreNo = centreNo;
    }

    public String getBillingNo() {
        return billingNo;
    }

    public void setBillingNo(String billingNo) {
        this.billingNo = billingNo;
    }
    
    public String getEarlyDis() {
        return earlyDis;
    }

    public void setEarlyDis(String earlyDis) {
        this.earlyDis = earlyDis;
    }
    
    public String getBillno() {
        return billno;
    }

    public void setBillno(String billno) {
        this.billno = billno;
    }

    public String getPaid() {
        return paid;
    }

    public void setPaid(String paid) {
        this.paid = paid;
    }
    
    public String getTech_reg() {
        return tech_reg;
    }

    public void setTech_reg(String tech_reg) {
        this.tech_reg = tech_reg;
    }

    public String getTech_thera() {
        return tech_thera;
    }

    public void setTech_thera(String tech_thera) {
        this.tech_thera = tech_thera;
    }

    public String getTech_dial() {
        return tech_dial;
    }

    public void setTech_dial(String tech_dial) {
        this.tech_dial = tech_dial;
    }

    public String getTech_othserv() {
        return tech_othserv;
    }

    public void setTech_othserv(String tech_othserv) {
        this.tech_othserv = tech_othserv;
    }

    public String getTech_othservamt() {
        return tech_othservamt;
    }

    public void setTech_othservamt(String tech_othservamt) {
        this.tech_othservamt = tech_othservamt;
    }
    
    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }
    
    public String getSess_id() {
        return sess_id;
    }

    public void setSess_id(String sess_id) {
        this.sess_id = sess_id;
    }

    public String getDrugs_issues() {
        return drugs_issues;
    }

    public ArrayList<PharmacyBill> getTech_pharm() {
        return tech_pharm;
    }

    public void setTech_pharm(ArrayList<PharmacyBill> tech_pharm) {
        this.tech_pharm = tech_pharm;
    }

    public ArrayList<Consumable> getTech_consumables() {
        return tech_consumables;
    }

    public void setTech_consumables(ArrayList<Consumable> tech_consumables) {
        this.tech_consumables = tech_consumables;
    }

    public void setDrugs_issues(String drugs_issues) {
        this.drugs_issues = drugs_issues;
    }

    public String getPatientId() {
        return patientId;
    }

    public void setPatientId(String patientId) {
        this.patientId = patientId;
    }

    public DialysisSession() {
    }

    public Patient getPatient() {
        return patient;
    }

    public void setPatient(Patient patient) {
        this.patient = patient;
    }

    public String getPatStart_time() {
        return patStart_time;
    }

    public void setPatStart_time(String patStart_time) {
        this.patStart_time = patStart_time;
    }

    public String getPatEnd_time() {
        return patEnd_time;
    }

    public void setPatEnd_time(String patEnd_time) {
        this.patEnd_time = patEnd_time;
    }

    public String getSch_emrg() {
        return sch_emrg;
    }

    public void setSch_emrg(String sch_emrg) {
        this.sch_emrg = sch_emrg;
    }

    public String getDiag_id() {
        return diag_id;
    }

    public void setDiag_id(String diag_id) {
        this.diag_id = diag_id;
    }

    public String getDiag_condn() {
        return diag_condn;
    }

    public void setDiag_condn(String diag_condn) {
        this.diag_condn = diag_condn;
    }

    public String getMach_id() {
        return mach_id;
    }

    public void setMach_id(String mach_id) {
        this.mach_id = mach_id;
    }

    public String getAccess_point() {
        return access_point;
    }

    public void setAccess_point(String access_point) {
        this.access_point = access_point;
    }

    public String getOpen_tech() {
        return open_tech;
    }

    public void setOpen_tech(String open_tech) {
        this.open_tech = open_tech;
    }

    public String getClose_tech() {
        return close_tech;
    }

    public void setClose_tech(String close_tech) {
        this.close_tech = close_tech;
    }

    public String getPre_site_condn() {
        return pre_site_condn;
    }

    public void setPre_site_condn(String pre_site_condn) {
        this.pre_site_condn = pre_site_condn;
    }

    public String getPre_condn_no_expl() {
        return pre_condn_no_expl;
    }

    public void setPre_condn_no_expl(String pre_condn_no_expl) {
        this.pre_condn_no_expl = pre_condn_no_expl;
    }

    public String getPre_patientWeight() {
        return pre_patientWeight;
    }

    public void setPre_patientWeight(String pre_patientWeight) {
        this.pre_patientWeight = pre_patientWeight;
    }

    public String getPre_notes() {
        return pre_notes;
    }

    public void setPre_notes(String pre_notes) {
        this.pre_notes = pre_notes;
    }

    public String[] getPre_patient_condns() {
        return pre_patient_condns;
    }

    public void setPre_patient_condns(String[] pre_patient_condns) {
        this.pre_patient_condns = pre_patient_condns;
    }

    public ArrayList<DurDialSess> getArrDurDial() {
        return arrDurDial;
    }

    public void setArrDurDial(ArrayList<DurDialSess> arrDurDial) {
        this.arrDurDial = arrDurDial;
    }

    public String getDrugs_given() {
        return drugs_given;
    }

    public void setDrugs_given(String drugs_given) {
        this.drugs_given = drugs_given;
    }

    public String getHepari() {
        return hepari;
    }

    public void setHepari(String hepari) {
        this.hepari = hepari;
    }

    public String getUF() {
        return UF;
    }

    public void setUF(String UF) {
        this.UF = UF;
    }

    public String getPost_site_condn() {
        return post_site_condn;
    }

    public void setPost_site_condn(String post_site_condn) {
        this.post_site_condn = post_site_condn;
    }

    public String getPost_condn_no_expl() {
        return post_condn_no_expl;
    }

    public void setPost_condn_no_expl(String post_condn_no_expl) {
        this.post_condn_no_expl = post_condn_no_expl;
    }

    public String getPost_patientWeight() {
        return post_patientWeight;
    }

    public void setPost_patientWeight(String post_patientWeight) {
        this.post_patientWeight = post_patientWeight;
    }

    public String getPost_notes() {
        return post_notes;
    }

    public void setPost_notes(String post_notes) {
        this.post_notes = post_notes;
    }

    public String[] getPost_patient_condns() {
        return post_patient_condns;
    }

    public void setPost_patient_condns(String[] post_patient_condns) {
        this.post_patient_condns = post_patient_condns;
    }

    public String getDischarge() {
        return discharge;
    }

    public void setDischarge(String discharge) {
        this.discharge = discharge;
    }

    public String getDiet_notes() {
        return diet_notes;
    }

    public void setDiet_notes(String diet_notes) {
        this.diet_notes = diet_notes;
    }

    public String getTech_signature() {
        return tech_signature;
    }

    public void setTech_signature(String tech_signature) {
        this.tech_signature = tech_signature;
    }

}
