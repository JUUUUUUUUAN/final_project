async function searcStore() {
    const keyword = document.getElementById("storeNameInput").value;

    if (!keyword || keyword.trim() === "") {
        alert("검색어를 입력해주세요.");
        return;
    }

    try {
        const params = new URLSearchParams({ keyword: keyword });
        const url = `/store/tab/store/search/store?${params.toString()}`;

        const response = await fetch(url, {
            method: "GET",
            headers: {
                "Content-Type": "application/json"
            }
        });

        if (!response.ok) {
            throw new Error(`서버 오류 발생: ${response.status}`);
        }

        const data = await response.json();

        let listHtml = "";
        let resultListElement = document.getElementById("storeResultList");

        if (data.length === 0) {
            listHtml = `<li class="list-group-item text-muted">검색 결과가 없습니다.</li>`;
        } else {
            data.forEach(store => {
                listHtml += `
                    <li class="list-group-item list-group-item-action d-flex align-items-center cursor-pointer" 
                        onclick="selectStore('${store.storeId}', '${store.storeName}', '${store.memName}')">
                        <div class="avatar avatar-sm me-2">
                            <span class="avatar-initial rounded-circle bg-label-primary">
                                ${store.storeName.charAt(0)}
                            </span>
                        </div>
                        <div class="d-flex flex-column">
                            <span class="fw-bold">${store.storeName}</span>
                            <small class="text-muted">${store.memName}</small>
                        </div>
                    </li>
                `;
            });
        }

        resultListElement.innerHTML = listHtml;
        resultListElement.style.display = 'block';

    } catch (error) {
        console.error("Fetch Error:", error);
        alert("가맹점 검색 중 오류가 발생했습니다.");
    }
}

function selectStore(id, name, member) {
    document.getElementById("storeId").value = id;
    document.getElementById("storeNameInput").value = `${name} (${member})`;
    
    document.getElementById("storeResultList").style.display = 'none';
}

document.addEventListener('click', function(e) {
    const target = e.target;
    const isInputGroup = target.closest('.input-group');
    const isResultList = target.closest('#storeResultList');

    if (!isInputGroup && !isResultList) {
        const listEl = document.getElementById('storeResultList');
        if (listEl) {
            listEl.style.display = 'none';
        }
    }
});

var registerContractModal = document.getElementById('registerContractModal');

function addFileField() {
    const container = document.getElementById('fileContainer');
    const newDiv = document.createElement('div');
    newDiv.className = 'input-group mb-2';
    newDiv.innerHTML = `
        <input type="file" class="form-control" name="contractFiles">
        <button type="button" class="btn btn-outline-danger" onclick="removeFileField(this)">
            <i class="bx bx-minus"></i>
        </button>
    `;
    container.appendChild(newDiv);
}

function removeFileField(button) {
    button.parentElement.remove();
}

$(document).ready(function() {
    $('#registerContractModal').off('hidden.bs.modal').on('hidden.bs.modal', function () {
        const form = document.getElementById('registerContractForm');
        if(form) form.reset();

        const storeIdEl = document.getElementById('storeId');
        if(storeIdEl) storeIdEl.value = '';

        const resultList = document.getElementById('storeResultList');
        if (resultList) {
            resultList.style.display = 'none';
            resultList.innerHTML = '';
        }

        const fileContainer = document.getElementById('fileContainer');
        if (fileContainer) {
            fileContainer.innerHTML = `
                <div class="input-group mb-2">
                    <input type="file" class="form-control" name="contractFiles">
                    <button type="button" class="btn btn-outline-primary" onclick="addFileField()">
                        <i class="bx bx-plus"></i>
                    </button>
                </div>
            `;
        }
    });
});

async function submitContractRegistration() {
    const storeId = document.getElementById('storeId').value;
    const contractRoyalti = document.getElementById('royalti').value;
    const contractDeposit = document.getElementById('deposit').value;
	const contractStartDate = document.getElementById('startDate').value;
	const contractEndDate = document.getElementById('endDate').value;
	const contractStatus = document.getElementById('contractStatus').value;
    
    if (!storeId) { alert("가맹점명을 선택해주세요."); return; }
    if (!contractRoyalti) { alert("로얄티를 입력해주세요."); return; }
    if (!contractDeposit) { alert("여신(보증금)을 입력해주세요."); return; }
	if (!contractStartDate || !contractEndDate) { alert("계약기간을 입력해주세요."); return; }

    const formData = new FormData();
	
	formData.append("storeId", storeId);
    formData.append("contractRoyalti", contractRoyalti);
    formData.append("contractDeposit", contractDeposit);
    formData.append("contractStartDate", contractStartDate);
    formData.append("contractEndDate", contractEndDate);
    formData.append("contractStatus", contractStatus);
	
	const fileInputs = document.getElementsByName("contractFiles");
	
	for (let i = 0; i < fileInputs.length; i++) {
        if (fileInputs[i].files.length > 0) {
            formData.append("files", fileInputs[i].files[0]); // fileInputs 태그에서 파일 객체 자체를 append 
        }
    }
	
	try {
	    const response = await fetch('/store/tab/contract/add', {
	        method: 'POST',
	        body: formData 
	    });

	    if (!response.ok) {
	        throw new Error(`서버 오류: ${response.status}`);
	    }

	    const result = await response.json(); 

	    alert("계약이 성공적으로 등록되었습니다.");
	    
	    const modalEl = document.getElementById('registerContractModal');
	    const modalInstance = bootstrap.Modal.getInstance(modalEl);
	    if (modalInstance) {
	        modalInstance.hide();
	    }
	    
	    loadTab('contract'); 

	} catch (error) {
	    console.error('Error:', error);
	    alert("등록 중 오류가 발생했습니다.");
	}	
	
}