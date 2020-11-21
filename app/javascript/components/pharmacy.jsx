import React from "react";

function Pharmacy(props) {
  const {
    name,
    address,
    distance,
  } = props;

  return (
    <>
      <div>{name}</div>
      <div>{address}</div>
      <div>{`${distance} miles`}</div>
    </>
  )
}

export default Pharmacy;
