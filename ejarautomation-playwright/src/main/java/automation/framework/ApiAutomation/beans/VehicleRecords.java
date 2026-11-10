package automation.framework.ApiAutomation.beans;

import com.google.gson.JsonElement;

import java.util.List;

/** The vehicle request, the response and the created vehicle. Record names must match the JSON keys exactly. */
public class VehicleRecords {

    // ---------- request: every JSON key of CreateVehicles ----------
    public record CreateVehiclesRequest(List<VehicleDto> vehicleDtos) {
    }

    public record VehicleDto(
            Boolean isBulkUploaded,
            String odometer,
            int fuelId,
            String branchId,
            VehicleManufacturingInfo vehicleManufacturingInfo,
            VehicleLicenseInfo vehicleLicenseInfo,
            VehicleInsuranceInfo vehicleInsuranceInfo,
            LocationInfo locationInfo,
            PurchaseInfo purchaseInfo,
            Specs specs,
            String countryId) {
    }

    public record VehicleManufacturingInfo(String modelId, int year, String chassisNo) {
    }

    public record VehicleLicenseInfo(String licenseTypeId, String usageTypeId, String plateNo) {
    }

    public record VehicleInsuranceInfo(String expiryDate, String number,
                                       String insuranceCompanyId, int accidentPolicyId) {
    }

    public record LocationInfo(String currentLocationId) {
    }

    public record PurchaseInfo(String vendorId, String date, String price) {
    }

    public record Specs(String colorId, String trimLevelId, String fuelTypeId,
                        int fuelTankSize, int engineSize) {
    }

    // ---------- response: {"result":"","targetUrl":null,"success":true,"error":null,"unAuthorizedRequest":false,"__abp":true} ----------
    public record CreateVehiclesResponse(JsonElement result, boolean success,
                                         JsonElement error, boolean unAuthorizedRequest) {
    }

    // ---------- the vehicle we created (the API returns no vehicle id, so these are the values we sent) ----------
    public record Vehicle(String plateNo, String chassisNo, String branchId,
                          String modelId, int year, String rawResponse) {
    }
}