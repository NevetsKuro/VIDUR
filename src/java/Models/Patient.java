/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Models;

import java.util.ArrayList;

/**
 *
 * @author Nevets
 */
public class Patient {

    String patientId;
    String patientName, Gender, Location, AccessPoint, Birthdate, PINCODE, Address, Blood_Group, Referring_Nephrologist,
            Fisrt_Session, No_of_Dialysis, Awaiting_Transplant, CKD_5D, SU_Decision, Heart_Fun, Injection_Frac,
            BP_Stable, Past_Habits, Liver_Fun, ECG_Arr, Type_of_Diet, Ini_Ano, Ini_Vom, Ini_Nau, Ini_Dia, updated_by, updated_date;
    int patient_rotations;
    ArrayList<Patient_contacts> contacts = new ArrayList<>();

    public String getLocation() {
        return Location;
    }

    public void setLocation(String Location) {
        this.Location = Location;
    }

    public String getBirthdate() {
        return Birthdate;
    }

    public void setBirthdate(String Birthdate) {
        this.Birthdate = Birthdate;
    }
    
    public int getPatient_rotations() {
        return patient_rotations;
    }

    public void setPatient_rotations(int patient_rotations) {
        this.patient_rotations = patient_rotations;
    }

    public ArrayList<Patient_contacts> getContacts() {
        return contacts;
    }

    public void setContacts(ArrayList<Patient_contacts> contacts) {
        this.contacts = contacts;
    }

    public ArrayList<Patient_contacts> getArrPatCont() {
        return contacts;
    }

    public void setArrPatCont(ArrayList<Patient_contacts> contacts) {
        this.contacts = contacts;
    }

    public String getUpdated_by() {
        return updated_by;
    }

    public void setUpdated_by(String updated_by) {
        this.updated_by = updated_by;
    }

    public String getUpdated_date() {
        return updated_date;
    }

    public void setUpdated_date(String updated_date) {
        this.updated_date = updated_date;
    }

    public String getPatientId() {
        return patientId;
    }

    public void setPatientId(String patientId) {
        this.patientId = patientId;
    }

    public String getGender() {
        return Gender;
    }

    public void setGender(String Gender) {
        this.Gender = Gender;
    }

    public Patient() {
    }

    public String getPatientName() {
        return patientName;
    }

    public void setPatientName(String patientName) {
        this.patientName = patientName;
    }

    public String getAccessPoint() {
        return AccessPoint;
    }

    public void setAccessPoint(String AccessPoint) {
        this.AccessPoint = AccessPoint;
    }

    public String getPINCODE() {
        return PINCODE;
    }

    public void setPINCODE(String PINCODE) {
        this.PINCODE = PINCODE;
    }

    public String getAddress() {
        return Address;
    }

    public void setAddress(String Address) {
        this.Address = Address;
    }

    public String getBlood_Group() {
        return Blood_Group;
    }

    public void setBlood_Group(String Blood_Group) {
        this.Blood_Group = Blood_Group;
    }

    public String getReferring_Nephrologist() {
        return Referring_Nephrologist;
    }

    public void setReferring_Nephrologist(String Referring_Nephrologist) {
        this.Referring_Nephrologist = Referring_Nephrologist;
    }

    public String getFisrt_Session() {
        return Fisrt_Session;
    }

    public void setFisrt_Session(String Fisrt_Session) {
        this.Fisrt_Session = Fisrt_Session;
    }

    public String getNo_of_Dialysis() {
        return No_of_Dialysis;
    }

    public void setNo_of_Dialysis(String No_of_Dialysis) {
        this.No_of_Dialysis = No_of_Dialysis;
    }

    public String getAwaiting_Transplant() {
        return Awaiting_Transplant;
    }

    public void setAwaiting_Transplant(String Awaiting_Transplant) {
        this.Awaiting_Transplant = Awaiting_Transplant;
    }

    public String getCKD_5D() {
        return CKD_5D;
    }

    public void setCKD_5D(String CKD_5D) {
        this.CKD_5D = CKD_5D;
    }

    public String getSU_Decision() {
        return SU_Decision;
    }

    public void setSU_Decision(String SU_Decision) {
        this.SU_Decision = SU_Decision;
    }

    public String getHeart_Fun() {
        return Heart_Fun;
    }

    public void setHeart_Fun(String Heart_Fun) {
        this.Heart_Fun = Heart_Fun;
    }

    public String getInjection_Frac() {
        return Injection_Frac;
    }

    public void setInjection_Frac(String Injection_Frac) {
        this.Injection_Frac = Injection_Frac;
    }

    public String getBP_Stable() {
        return BP_Stable;
    }

    public void setBP_Stable(String BP_Stable) {
        this.BP_Stable = BP_Stable;
    }

    public String getPast_Habits() {
        return Past_Habits;
    }

    public void setPast_Habits(String Past_Habits) {
        this.Past_Habits = Past_Habits;
    }

    public String getLiver_Fun() {
        return Liver_Fun;
    }

    public void setLiver_Fun(String Liver_Fun) {
        this.Liver_Fun = Liver_Fun;
    }

    public String getECG_Arr() {
        return ECG_Arr;
    }

    public void setECG_Arr(String ECG_Arr) {
        this.ECG_Arr = ECG_Arr;
    }

    public String getType_of_Diet() {
        return Type_of_Diet;
    }

    public void setType_of_Diet(String Type_of_Diet) {
        this.Type_of_Diet = Type_of_Diet;
    }

    public String getIni_Ano() {
        return Ini_Ano;
    }

    public void setIni_Ano(String Ini_Ano) {
        this.Ini_Ano = Ini_Ano;
    }

    public String getIni_Vom() {
        return Ini_Vom;
    }

    public void setIni_Vom(String Ini_Vom) {
        this.Ini_Vom = Ini_Vom;
    }

    public String getIni_Nau() {
        return Ini_Nau;
    }

    public void setIni_Nau(String Ini_Nau) {
        this.Ini_Nau = Ini_Nau;
    }

    public String getIni_Dia() {
        return Ini_Dia;
    }

    public void setIni_Dia(String Ini_Dia) {
        this.Ini_Dia = Ini_Dia;
    }
}
